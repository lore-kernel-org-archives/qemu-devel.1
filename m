Received: from eggs.gnu.org ([2001:4830:134:3::10]:40421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1e55Wl-0001tx-KU
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 03:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1e55Wi-00078X-Go
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 03:46:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1e55Wi-00077p-A5
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 03:46:00 -0400
Date: Thu, 19 Oct 2017 08:45:56 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171019074556.GC18719@redhat.com>
References: <1506683421-27004-1-git-send-email-amarnath.valluri@intel.com>
	<1506683421-27004-10-git-send-email-amarnath.valluri@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506683421-27004-10-git-send-email-amarnath.valluri@intel.com>
Subject: Re: [Qemu-devel] [PATCH v10 9/9] tpm: Move tpm_cleanup() to right
 place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@gmail.com, stefanb@linux.vnet.ibm.com


On Fri, Sep 29, 2017 at 02:10:21PM +0300, Amarnath Valluri wrote:
> As Emulator TPM backend uses chardev, tpm cleanup should happen before chardev
> similar to other vhost-users.
> 
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---
>  tpm.c | 1 -
>  vl.c  | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tpm.c b/tpm.c
> index 3b8c7ed..3122227 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -172,7 +172,6 @@ int tpm_init(void)
>          return -1;
>      }
>  
> -    atexit(tpm_cleanup);
>      return 0;
>  }
>  
> diff --git a/vl.c b/vl.c
> index 9bb5058..ed86209 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4893,6 +4893,7 @@ int main(int argc, char **argv, char **envp)
>      res_free();
>  
>      /* vhost-user must be cleaned up before chardevs.  */
> +    tpm_cleanup();
>      net_cleanup();
>      audio_cleanup();
>      monitor_cleanup();

This breaks compilation with --disable-tpm.  I'll post a trivial
patch shortly.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
