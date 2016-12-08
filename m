Received: from eggs.gnu.org ([2001:4830:134:3::10]:38238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEyxr-0000gt-GT
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEyxq-0001Dr-FV
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:42:23 -0500
Date: Thu, 8 Dec 2016 13:42:08 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161208134208.GG26641@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
	<1481203391-9523-3-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481203391-9523-3-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/6] iscsi: Handle -iscsi user/password
 in bdrv_parse_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, pl@kamp.de, ptoscano@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Thu, Dec 08, 2016 at 02:23:07PM +0100, Kevin Wolf wrote:
> This splits the logic in the old parse_chap() function into a part that
> parses the -iscsi options into the new driver-specific options, and
> another part that actually applies those options (called apply_chap()
> now).
> 
> Note that this means that username and password specified with -iscsi
> only take effect when a URL is provided. This is intentional, -iscsi is
> a legacy interface only supported for compatibility, new users should
> use the proper driver-specific options.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/iscsi.c | 72 +++++++++++++++++++++++++++++++----------------------------
>  1 file changed, 38 insertions(+), 34 deletions(-)
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 7a6664e..c5106c1 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -1235,29 +1235,14 @@ retry:
>      return 0;
>  }
>  
> -static void parse_chap(struct iscsi_context *iscsi, const char *target,
> +static void apply_chap(struct iscsi_context *iscsi, QemuOpts *opts,
>                         Error **errp)
>  {
> -    QemuOptsList *list;
> -    QemuOpts *opts;
>      const char *user = NULL;
>      const char *password = NULL;
>      const char *secretid;
>      char *secret = NULL;
>  
> -    list = qemu_find_opts("iscsi");
> -    if (!list) {
> -        return;
> -    }
> -
> -    opts = qemu_opts_find(list, target);
> -    if (opts == NULL) {
> -        opts = QTAILQ_FIRST(&list->head);
> -        if (!opts) {
> -            return;
> -        }
> -    }
> -
>      user = qemu_opt_get(opts, "user");
>      if (!user) {
>          return;
> @@ -1586,6 +1571,35 @@ out:
>      }
>  }
>  
> +static void iscsi_parse_iscsi_option(const char *target, QDict *options)
> +{
> +    QemuOptsList *list;
> +    QemuOpts *opts;
> +    const char *user;
> +
> +    list = qemu_find_opts("iscsi");
> +    if (!list) {
> +        return;
> +    }
> +
> +    opts = qemu_opts_find(list, target);
> +    if (opts == NULL) {
> +        opts = QTAILQ_FIRST(&list->head);
> +        if (!opts) {
> +            return;
> +        }
> +    }
> +
> +    user = qemu_opt_get(opts, "user");
> +    if (user) {
> +        qdict_set_default_str(options, "user", user);
> +        qdict_set_default_str(options, "password",
> +                              qemu_opt_get(opts, "password"));
> +        qdict_set_default_str(options, "password-secret",
> +                              qemu_opt_get(opts, "password-secret"));

This core dumps if you set '-iscsi user=foo' but don't set password
or password-secret

#0  0x00007fffda7e2046 in strlen () at /lib64/libc.so.6
#1  0x0000555555b012f9 in qstring_from_str (str=str@entry=0x0) at qobject/qstring.c:66
#2  0x0000555555b02148 in qdict_set_default_str (dst=dst@entry=0x5555566ea7d0, key=key@entry=0x555555b2238b "password", val=0x0) at qobject/qdict.c:490
#3  0x0000555555ab515f in iscsi_parse_iscsi_option (options=0x5555566ea7d0, target=0x5555566f0eb0 "iqn.2004-04.fedora:fedora25:iscsi.kvm") at block/iscsi.c:1545
#4  0x0000555555ab515f in iscsi_parse_filename (filename=<optimized out>, options=0x5555566ea7d0, errp=<optimized out>) at block/iscsi.c:1610


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
