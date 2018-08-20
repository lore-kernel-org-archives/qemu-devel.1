Received: from eggs.gnu.org ([2001:4830:134:3::10]:50529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frjtZ-0002IC-DB
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frjtY-0004gy-En
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:06:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1frjtY-0004ge-9A
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:06:56 -0400
References: <20180704181010.GA918@computer>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cec51a71-2339-d764-e6df-88d311adb9d9@redhat.com>
Date: Mon, 20 Aug 2018 15:06:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180704181010.GA918@computer>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] module: Use QEMU_MODULE_DIR as a search
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ryang <decatf@gmail.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 04/07/2018 20:10, ryang wrote:
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
> QEMU_MODULE_DIR=~/.local/var/pmbootstrap/chroot_native/usr/lib/qemu/
> 
> [1] https://postmarketos.org/
> 

Queued, thanks.

Paolo

> Signed-off-by: ryang <decatf@gmail.com>
> ---
> 
> v2:
>  - fix checkpatch errors
> v3:
>  - initialize n_dirs variable
> v4:
>  - change env variable suffix from _PATH to _DIR
>  - renamed search_path to search_dir and make it const
> 
>  util/module.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/util/module.c b/util/module.c
> index c909737..1259dd3 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -162,9 +162,10 @@ void module_load_one(const char *prefix, const char *lib_name)
>  #ifdef CONFIG_MODULES
>      char *fname = NULL;
>      char *exec_dir;
> -    char *dirs[3];
> +    const char *search_dir;
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
> +    search_dir = getenv("QEMU_MODULE_DIR");
> +    if (search_dir != NULL) {
> +        dirs[n_dirs++] = g_strdup_printf("%s", search_dir);
> +    }
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
> 
