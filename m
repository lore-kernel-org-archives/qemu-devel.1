Received: from eggs.gnu.org ([2001:4830:134:3::10]:51675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cUH2P-0007Ji-8s
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cUH2M-0002xY-0i
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:02:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cUH2L-0002xB-PY
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:02:13 -0500
Date: Thu, 19 Jan 2017 18:02:07 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170119180206.GI2085@work-vm>
References: <1484566314-3987-1-git-send-email-ashijeetacharya@gmail.com>
	<1484566314-3987-3-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484566314-3987-3-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/5] migration: Add a new option to
 enable only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

* Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
> Add a new option "--only-migratable" in qemu which will allow to add
> only those devices which will not fail qemu after migration. Devices
> set with the flag 'unmigratable' cannot be added when this option will
> be used.
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/migration.h | 3 +++
>  qemu-options.hx               | 9 +++++++++
>  vl.c                          | 4 ++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index c309d23..40b3697 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -38,6 +38,9 @@
>  #define QEMU_VM_COMMAND              0x08
>  #define QEMU_VM_SECTION_FOOTER       0x7e
>  
> +/* for vl.c */
> +extern int only_migratable;
> +
>  struct MigrationParams {
>      bool blk;
>      bool shared;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index c534a2f..1e16ae8 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3574,6 +3574,15 @@ be used to change settings (such as migration parameters) prior to issuing
>  the migrate_incoming to allow the migration to begin.
>  ETEXI
>  
> +DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
> +    "-only-migratable     allow only migratable devices\n", QEMU_ARCH_ALL)
> +STEXI
> +@item -only-migratable
> +@findex -only-migratable
> +Only allow migratable devices. Devices will not be allowed to enter an
> +unmigratable state.
> +ETEXI
> +
>  DEF("nodefaults", 0, QEMU_OPTION_nodefaults, \
>      "-nodefaults     don't create default devices\n", QEMU_ARCH_ALL)
>  STEXI
> diff --git a/vl.c b/vl.c
> index c643d3f..cbcb459 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -180,6 +180,7 @@ bool boot_strict;
>  uint8_t *boot_splash_filedata;
>  size_t boot_splash_filedata_size;
>  uint8_t qemu_extra_params_fw[2];
> +int only_migratable; /* turn it off unless user states otherwise */
>  
>  int icount_align_option;
>  
> @@ -3910,6 +3911,9 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  incoming = optarg;
>                  break;
> +            case QEMU_OPTION_only_migratable:
> +                only_migratable = 1;
> +                break;
>              case QEMU_OPTION_nodefaults:
>                  has_defaults = 0;
>                  break;
> -- 
> 2.6.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
