Received: from eggs.gnu.org ([2001:4830:134:3::10]:44048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fXqm8-0005ID-Jq
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fXqm5-0007hX-GG
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:25:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58338 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1fXqm5-0007gp-BW
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:25:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DEB00406E81E
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 16:24:59 +0000 (UTC)
References: <20180626154028.11133-1-pbonzini@redhat.com>
	<20180626154028.11133-2-pbonzini@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <32fe66cd-8d7c-f49e-7ac6-f6851f9d348f@redhat.com>
Date: Tue, 26 Jun 2018 18:24:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180626154028.11133-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] pr-helper: fix --socket-path default
 in help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 06/26/2018 05:40 PM, Paolo Bonzini wrote:
> Currently --help shows "(default '(null)')" for the -k/--socket-path
> option.  Fix it by getting the default path in /var/run.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scsi/qemu-pr-helper.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> index d0f83176e1..4057cf355c 100644
> --- a/scsi/qemu-pr-helper.c
> +++ b/scsi/qemu-pr-helper.c
> @@ -74,8 +74,16 @@ static int uid = -1;
>  static int gid = -1;
>  #endif
>  
> +static void compute_default_paths(void)
> +{
> +    if (!socket_path) {
> +        socket_path = qemu_get_local_state_pathname("run/qemu-pr-helper.sock");
> +    }
> +}
> +

Pre-existing, but pidfile path is computed elsewhere. I'll post a patch
that cleans things up. Not a show stopper for this one though.

Reviewed-by: Michal Privoznik <mprivozn@redhat.com>

Michal
