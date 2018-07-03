Received: from eggs.gnu.org ([2001:4830:134:3::10]:32848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1faRVW-0007sO-FQ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1faRVS-0002Fr-MI
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:02:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1faRVS-0002Fk-GT
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:02:34 -0400
Date: Tue, 3 Jul 2018 21:02:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180703200230.GA30452@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180703191904.GA29474@computer>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180703191904.GA29474@computer>
Subject: Re: [Qemu-devel] [PATCH v3] module: Use QEMU_MODULE_PATH as a
 search path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ryang <decatf@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

On Tue, Jul 03, 2018 at 03:19:04PM -0400, ryang wrote:
> The current paths for modules are CONFIG_QEMU_MODDIR and paths relative
> to the executable. Qemu and its modules can be installed and executed in
> paths that are different from these search paths. This change allows
> a search path to be specified by environment variable.
> 
> An example usage for this is postmarketOS[1]. This is a build environment
> for Alpine Linux. It sets up Alpine Linux in a chroot environment.
> Alpine's Qemu packages are installed in the chroot. The Alpine Linux Qemu
> package is used to test compiled Alpine Linux system images. This way there
> isn't a reliance on the which ever version of Qemu the host system / distro
> provides.
> 
> postmarketOS executes Qemu on host system outside of the chroot
> The Qemu module search path needs to point to the location of the
> chroot relative to the host system.
> 
> e.g.
> The root of the Alpine Linux chroot is:
> ~/.local/var/pmbootstrap/chroot_native/
> 
> Alpine's Qemu is installed at
> ~/.local/var/pmbootstrap/chroot_native/usr/bin/
> 
> The Qemu module search path needs to be:
> QEMU_MODULE_PATH=~/.local/var/pmbootstrap/chroot_native/usr/lib/qemu/
> 
> [1] https://postmarketos.org/
> 
> Signed-off-by: ryang <decatf@gmail.com>
> ---
> 
> v2:
>  - fix checkpatch errors
> v3:
>  - initialize n_dirs variable
> 
>  util/module.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/util/module.c b/util/module.c
> index c909737..612f00e 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -162,9 +162,10 @@ void module_load_one(const char *prefix, const char *lib_name)
>  #ifdef CONFIG_MODULES
>      char *fname = NULL;
>      char *exec_dir;
> -    char *dirs[3];
> +    char *search_path;

This should be "const"

> +    char *dirs[4];
>      char *module_name;
> -    int i = 0;
> +    int i = 0, n_dirs = 0;
>      int ret;
>      static GHashTable *loaded_modules;
>  
> @@ -186,14 +187,19 @@ void module_load_one(const char *prefix, const char *lib_name)
>      g_hash_table_insert(loaded_modules, module_name, module_name);
>  
>      exec_dir = qemu_get_exec_dir();
> -    dirs[i++] = g_strdup_printf("%s", CONFIG_QEMU_MODDIR);
> -    dirs[i++] = g_strdup_printf("%s/..", exec_dir ? : "");
> -    dirs[i++] = g_strdup_printf("%s", exec_dir ? : "");
> -    assert(i == ARRAY_SIZE(dirs));
> +    search_path = getenv("QEMU_MODULE_PATH");
> +    if (search_path != NULL) {
> +        dirs[n_dirs++] = g_strdup_printf("%s", search_path);
> +    }

For an env variable named with a "_PATH", I'd expect to have a colon
separated list of directories, but this only allows a single directory.

If we only want a single dir for simplicity, then use a _DIR suffix
instead of _PATH, otherwise implement support for splitting on ":"

> +    dirs[n_dirs++] = g_strdup_printf("%s", CONFIG_QEMU_MODDIR);
> +    dirs[n_dirs++] = g_strdup_printf("%s/..", exec_dir ? : "");
> +    dirs[n_dirs++] = g_strdup_printf("%s", exec_dir ? : "");
> +    assert(n_dirs <= ARRAY_SIZE(dirs));
> +
>      g_free(exec_dir);
>      exec_dir = NULL;
>  
> -    for (i = 0; i < ARRAY_SIZE(dirs); i++) {
> +    for (i = 0; i < n_dirs; i++) {
>          fname = g_strdup_printf("%s/%s%s",
>                  dirs[i], module_name, HOST_DSOSUF);
>          ret = module_load_file(fname);
> @@ -205,7 +211,7 @@ void module_load_one(const char *prefix, const char *lib_name)
>          }
>      }
>  
> -    for (i = 0; i < ARRAY_SIZE(dirs); i++) {
> +    for (i = 0; i < n_dirs; i++) {
>          g_free(dirs[i]);
>      }
>  
> -- 
> 2.7.4
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
