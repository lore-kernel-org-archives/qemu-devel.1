Received: from eggs.gnu.org ([2001:4830:134:3::10]:32845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fVdOC-00030W-Iw
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fVdO9-0003BY-C9
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:43:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55304 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1fVdO9-0003BH-8C
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:43:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2C4140201A1
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 13:43:07 +0000 (UTC)
References: <1529501059-163139-1-git-send-email-imammedo@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <680d6cd0-2e39-660c-184b-e2832f9a5b2a@redhat.com>
Date: Wed, 20 Jun 2018 15:43:05 +0200
MIME-Version: 1.0
In-Reply-To: <1529501059-163139-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vl.c: do not allow --daemonize in
 combination with --preconfig CLI option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: pkrempa@redhat.com, ehabkost@redhat.com, berrange@redhat.com

On 06/20/2018 03:24 PM, Igor Mammedov wrote:
> some users when using --daemonize expect that QEMU will parse CLI options,
> initialize VM and only then complete daemonzation by signalling lead
> process to exit and start listening on monitor socket. So users treat
> parent process exit as sync point to connect to QEMU's monitor.
> 
> That however doesn't work when --preconfig options is used, since it
> provides monitor before completing daemonization and expects user to
> issue exit-preconfig command when additional configuration via monitor
> is finished. We also can't move completing daemonization before
> preconfig monitor becomes available, since that would imply:
>   * partially loosing ability to configure QEMU instance in --preconfig
>     mode since QEMU might drop privileges, chroot and do other things
>     when daemonization is completed
>   * lead to loss of error messages in case they would happen after
>     daemonization
> 
> Be proactive now and make options mutually exclusive, so users would
> get clear error message instead of waiting for lead process exit
> indefinitely before connecting to monitor.
> 
> PS:
> In case someone would come up with usecase where both options should
> be enabled at the same time we could drop this restriction as far
> as daemonization point is left where it is now (os_setup_post).
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  vl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

ACK

Michal
