Received: from eggs.gnu.org ([2001:4830:134:3::10]:57397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezUDq-0000yV-Qd
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezUDm-0006hX-Tq
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:27:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ezUDm-0006hF-Mh
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:27:34 -0400
Date: Fri, 23 Mar 2018 18:27:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180323212732.GG28161@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-5-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520860275-101576-5-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/9] hmp: disable monitor in preconfig
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Mon, Mar 12, 2018 at 02:11:10PM +0100, Igor Mammedov wrote:
> Ban it for now, if someone would need it to work early,
> one would have to implement checks if HMP command is valid
> at preconfig state.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v4:
>   * v3 was only printing error but not preventing command execution,
>     Fix it by returning after printing error message.
>     ("Dr. David Alan Gilbert" <dgilbert@redhat.com>)
> ---
>  monitor.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/monitor.c b/monitor.c
> index a4417f2..ea0ca57 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3104,6 +3104,11 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
>  
>      trace_handle_hmp_command(mon, cmdline);
>  
> +    if (runstate_check(RUN_STATE_PRECONFIG)) {
> +        monitor_printf(mon, "HMP not available in preconfig state\n");
> +        return;

Not even the "cont" command?  It would be useful for testing
-preconfig.

-- 
Eduardo
