Received: from eggs.gnu.org ([209.51.188.92]:57006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDn2Y-00089Q-8l
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDn2X-0005gJ-Dg
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:27:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hDn2X-0005f0-0h
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:27:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77F3C307EA98
	for <qemu-devel@nongnu.org>; Tue,  9 Apr 2019 09:27:35 +0000 (UTC)
References: <20190318171521.8524-1-pbonzini@redhat.com>
	<20190318171521.8524-3-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f26d8181-ed18-7141-b763-6bf329a7d91a@redhat.com>
Date: Tue, 9 Apr 2019 11:27:31 +0200
MIME-Version: 1.0
In-Reply-To: <20190318171521.8524-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/13] qgraph: fix qos_node_contains with
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 18/03/2019 18.15, Paolo Bonzini wrote:
> Currently, if qos_node_contains was passed options, it would still
> create an edge without any options.  Instead, in that case
> NULL acts as a terminator.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/libqos/qgraph.c | 12 ++++++++----
>  tests/libqos/qgraph.h | 15 +++++++++------
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/libqos/qgraph.c b/tests/libqos/qgraph.c
> index 122efc1b7b..9f738f1849 100644
> --- a/tests/libqos/qgraph.c
> +++ b/tests/libqos/qgraph.c
> @@ -630,15 +630,19 @@ void qos_node_create_driver(const char *name, QOSCreateDriverFunc function)
>  }
>  
>  void qos_node_contains(const char *container, const char *contained,
> -                       ...)
> +                       QOSGraphEdgeOptions *opts, ...)
>  {
>      va_list va;
> -    va_start(va, contained);
> -    QOSGraphEdgeOptions *opts;
>  
> +    if (opts == NULL) {
> +        add_edge(container, contained, QEDGE_CONTAINS, NULL);
> +        return;
> +    }
> +
> +    va_start(va, contained);

As patchew complained - you've got to either replace "contained" with
"opts" here, or switch the order of the options in the prototype.

 Thomas
