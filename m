Received: from eggs.gnu.org ([2001:4830:134:3::10]:38338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQYq2-00053P-Di
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQYpy-00041s-AH
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:50:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fQYpy-00041T-3w
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:50:54 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4162F81240
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 13:50:53 +0000 (UTC)
Date: Wed, 6 Jun 2018 10:50:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180606135051.GR7451@localhost.localdomain>
References: <20180605183001.GO7451@localhost.localdomain>
	<1528274225-90644-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528274225-90644-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/2] vl: fix use of --daemonize with
 --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, ldoktor@redhat.com, eblake@redhat.com

On Wed, Jun 06, 2018 at 10:37:05AM +0200, Igor Mammedov wrote:
[...]
> @@ -4578,6 +4579,13 @@ int main(int argc, char **argv, char **envp)
>      parse_numa_opts(current_machine);
>  
>      /* do monitor/qmp handling at preconfig state if requested */
> +    if (!preconfig_exit_requested && is_daemonized()) {
> +        /* signal parent QEMU to exit, libvirt treats it as a sign
> +         * that monitor socket is ready to accept connections
> +         */
> +        os_setup_post();
> +        os_setup_post_done = true;
> +    }

I liked your version of os_setup_post() in v3, where the
os_setup_post_done check is done inside os_setup_post().

>      main_loop();
>  
>      /* from here on runstate is RUN_STATE_PRELAUNCH */
> @@ -4707,8 +4715,10 @@ int main(int argc, char **argv, char **envp)
>      }
>  
>      accel_setup_post(current_machine);
> -    os_setup_post();
>  
> +    if (!os_setup_post_done) {
> +        os_setup_post();
> +    }
>      main_loop();
>  
>      gdbserver_cleanup();
> -- 
> 2.7.4
> 

-- 
Eduardo
