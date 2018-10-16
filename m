Received: from eggs.gnu.org ([2001:4830:134:3::10]:51356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gCJ8R-00047C-6K
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 02:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gCJ8K-0000K1-2j
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 02:47:18 -0400
MIME-Version: 1.0
References: <20181015172817.19796-1-mreitz@redhat.com>
	<20181015172817.19796-2-mreitz@redhat.com>
In-Reply-To: <20181015172817.19796-2-mreitz@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 16 Oct 2018 10:46:17 +0400
Message-ID: <CAJ+F1CJtT6u6ejLwmTTRWz96c6QW13pZVMF1+hTLXxD1qeV1XQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] option: Make option help nicer to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "open list:Block layer core" <qemu-block@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

Hi

On Mon, Oct 15, 2018 at 9:34 PM Max Reitz <mreitz@redhat.com> wrote:
>
> This adds some whitespace into the option help (including indentation)
> and replaces '=3D' by ': ' (not least because '=3D' should be used for
> values, not types).

Without strong preference, I like the '=3D' better: it's the expected
syntax for the command line argument. (also, --help and man pages
describe options with "foo=3Dtype", not "foo: type")

> Furthermore, the list name is no longer printed as
> part of every line, but only once in advance, and only if the caller did
> not print a caption already.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

looks good to me otherwise

> ---
>  include/qemu/option.h      |   2 +-
>  qemu-img.c                 |   4 +-
>  util/qemu-option.c         |  31 +-
>  tests/qemu-iotests/082.out | 956 ++++++++++++++++++-------------------
>  4 files changed, 505 insertions(+), 488 deletions(-)
>
> diff --git a/include/qemu/option.h b/include/qemu/option.h
> index 3dfb4493cc..844587cab3 100644
> --- a/include/qemu/option.h
> +++ b/include/qemu/option.h
> @@ -132,7 +132,7 @@ typedef int (*qemu_opts_loopfunc)(void *opaque, QemuO=
pts *opts, Error **errp);
>  int qemu_opts_foreach(QemuOptsList *list, qemu_opts_loopfunc func,
>                        void *opaque, Error **errp);
>  void qemu_opts_print(QemuOpts *opts, const char *sep);
> -void qemu_opts_print_help(QemuOptsList *list);
> +void qemu_opts_print_help(QemuOptsList *list, bool print_caption);
>  void qemu_opts_free(QemuOptsList *list);
>  QemuOptsList *qemu_opts_append(QemuOptsList *dst, QemuOptsList *list);
>
> diff --git a/qemu-img.c b/qemu-img.c
> index b12f4cd19b..4c96db7ba4 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -269,7 +269,7 @@ static int print_block_option_help(const char *filena=
me, const char *fmt)
>      }
>
>      printf("Supported options:\n");
> -    qemu_opts_print_help(create_opts);
> +    qemu_opts_print_help(create_opts, false);
>      qemu_opts_free(create_opts);
>      return 0;
>  }
> @@ -3773,7 +3773,7 @@ static int print_amend_option_help(const char *form=
at)
>      assert(drv->create_opts);
>
>      printf("Creation options for '%s':\n", format);
> -    qemu_opts_print_help(drv->create_opts);
> +    qemu_opts_print_help(drv->create_opts, false);
>      printf("\nNote that not all of these options may be amendable.\n");
>      return 0;
>  }
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 9a5f263294..ce79332912 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -224,7 +224,14 @@ static const char *opt_type_to_string(enum QemuOptTy=
pe type)
>      g_assert_not_reached();
>  }
>
> -void qemu_opts_print_help(QemuOptsList *list)
> +/**
> + * Print the list of options available in the given list.  If
> + * @print_caption is true, a caption (including the list name, if it
> + * exists) is printed.  The options itself will be indented, so
> + * @print_caption should only be set to false if the caller prints its
> + * own custom caption (so that the indentation makes sense).
> + */
> +void qemu_opts_print_help(QemuOptsList *list, bool print_caption)
>  {
>      QemuOptDesc *desc;
>      int i;
> @@ -234,10 +241,7 @@ void qemu_opts_print_help(QemuOptsList *list)
>      desc =3D list->desc;
>      while (desc && desc->name) {
>          GString *str =3D g_string_new(NULL);
> -        if (list->name) {
> -            g_string_append_printf(str, "%s.", list->name);
> -        }
> -        g_string_append_printf(str, "%s=3D%s", desc->name,
> +        g_string_append_printf(str, "%s: %s", desc->name,
>                                 opt_type_to_string(desc->type));
>          if (desc->help) {
>              g_string_append_printf(str, " - %s", desc->help);
> @@ -247,8 +251,21 @@ void qemu_opts_print_help(QemuOptsList *list)
>      }
>
>      g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);
> +    if (print_caption && array->len > 0) {
> +        if (list->name) {
> +            printf("%s options:\n", list->name);
> +        } else {
> +            printf("Options:\n");
> +        }
> +    } else if (array->len =3D=3D 0) {
> +        if (list->name) {
> +            printf("There are no options for %s.\n", list->name);
> +        } else {
> +            printf("No options available.\n");
> +        }
> +    }
>      for (i =3D 0; i < array->len; i++) {
> -        printf("%s\n", (char *)array->pdata[i]);
> +        printf("  %s\n", (char *)array->pdata[i]);
>      }
>      g_ptr_array_set_free_func(array, g_free);
>      g_ptr_array_free(array, true);
> @@ -930,7 +947,7 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list,=
 const char *params,
>      opts =3D opts_parse(list, params, permit_abbrev, false, &invalidp, &=
err);
>      if (err) {
>          if (invalidp && has_help_option(params)) {
> -            qemu_opts_print_help(list);
> +            qemu_opts_print_help(list, true);
>              error_free(err);
>          } else {
>              error_report_err(err);
> diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
> index 19e9fb13ff..115745f474 100644
> --- a/tests/qemu-iotests/082.out
> +++ b/tests/qemu-iotests/082.out
> @@ -44,171 +44,171 @@ cluster_size: 8192
>
>  Testing: create -f qcow2 -o help TEST_DIR/t.qcow2 128M
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: create -f qcow2 -o ? TEST_DIR/t.qcow2 128M
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: create -f qcow2 -o cluster_size=3D4k,help TEST_DIR/t.qcow2 128M
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: create -f qcow2 -o cluster_size=3D4k,? TEST_DIR/t.qcow2 128M
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: create -f qcow2 -o help,cluster_size=3D4k TEST_DIR/t.qcow2 128M
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: create -f qcow2 -o ?,cluster_size=3D4k TEST_DIR/t.qcow2 128M
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: create -f qcow2 -o cluster_size=3D4k -o help TEST_DIR/t.qcow2 1=
28M
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: create -f qcow2 -o cluster_size=3D4k -o ? TEST_DIR/t.qcow2 128M
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: create -f qcow2 -u -o backing_file=3DTEST_DIR/t.qcow2,,help TES=
T_DIR/t.qcow2 128M
>  Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 backing_file=
=3DTEST_DIR/t.qcow2,,help cluster_size=3D65536 lazy_refcounts=3Doff refcoun=
t_bits=3D16
> @@ -227,27 +227,27 @@ qemu-img: Invalid option list: ,,
>
>  Testing: create -f qcow2 -o help
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: create -o help
>  Supported options:
> -size             Virtual disk size
> +  size: size - Virtual disk size
>
>  Testing: create -f bochs -o help
>  qemu-img: Format driver 'bochs' does not support image creation
> @@ -300,171 +300,171 @@ cluster_size: 8192
>
>  Testing: convert -O qcow2 -o help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: convert -O qcow2 -o ? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: convert -O qcow2 -o cluster_size=3D4k,help TEST_DIR/t.qcow2 TES=
T_DIR/t.qcow2.base
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: convert -O qcow2 -o cluster_size=3D4k,? TEST_DIR/t.qcow2 TEST_D=
IR/t.qcow2.base
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: convert -O qcow2 -o help,cluster_size=3D4k TEST_DIR/t.qcow2 TES=
T_DIR/t.qcow2.base
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: convert -O qcow2 -o ?,cluster_size=3D4k TEST_DIR/t.qcow2 TEST_D=
IR/t.qcow2.base
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: convert -O qcow2 -o cluster_size=3D4k -o help TEST_DIR/t.qcow2 =
TEST_DIR/t.qcow2.base
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: convert -O qcow2 -o cluster_size=3D4k -o ? TEST_DIR/t.qcow2 TES=
T_DIR/t.qcow2.base
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> -nocow            Turn off copy-on-write (valid only on btrfs)
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: convert -O qcow2 -o backing_file=3DTEST_DIR/t.qcow2,,help TEST_=
DIR/t.qcow2 TEST_DIR/t.qcow2.base
>  qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open backing=
 file: Could not open 'TEST_DIR/t.qcow2,help': No such file or directory
> @@ -483,27 +483,27 @@ qemu-img: Invalid option list: ,,
>
>  Testing: convert -O qcow2 -o help
>  Supported options:
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Testing: convert -o help
>  Supported options:
> -size             Virtual disk size
> +  size: size - Virtual disk size
>
>  Testing: convert -O bochs -o help
>  qemu-img: Format driver 'bochs' does not support image creation
> @@ -564,177 +564,177 @@ cluster_size: 65536
>
>  Testing: amend -f qcow2 -o help TEST_DIR/t.qcow2
>  Creation options for 'qcow2':
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Note that not all of these options may be amendable.
>
>  Testing: amend -f qcow2 -o ? TEST_DIR/t.qcow2
>  Creation options for 'qcow2':
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Note that not all of these options may be amendable.
>
>  Testing: amend -f qcow2 -o cluster_size=3D4k,help TEST_DIR/t.qcow2
>  Creation options for 'qcow2':
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Note that not all of these options may be amendable.
>
>  Testing: amend -f qcow2 -o cluster_size=3D4k,? TEST_DIR/t.qcow2
>  Creation options for 'qcow2':
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Note that not all of these options may be amendable.
>
>  Testing: amend -f qcow2 -o help,cluster_size=3D4k TEST_DIR/t.qcow2
>  Creation options for 'qcow2':
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Note that not all of these options may be amendable.
>
>  Testing: amend -f qcow2 -o ?,cluster_size=3D4k TEST_DIR/t.qcow2
>  Creation options for 'qcow2':
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Note that not all of these options may be amendable.
>
>  Testing: amend -f qcow2 -o cluster_size=3D4k -o help TEST_DIR/t.qcow2
>  Creation options for 'qcow2':
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Note that not all of these options may be amendable.
>
>  Testing: amend -f qcow2 -o cluster_size=3D4k -o ? TEST_DIR/t.qcow2
>  Creation options for 'qcow2':
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Note that not all of these options may be amendable.
>
> @@ -757,29 +757,29 @@ qemu-img: Invalid option list: ,,
>
>  Testing: amend -f qcow2 -o help
>  Creation options for 'qcow2':
> -size             Virtual disk size
> -compat           Compatibility level (0.10 or 1.1)
> -backing_file     File name of a base image
> -backing_fmt      Image format of the base image
> -encryption       Encrypt the image with format 'aes'. (Deprecated in fav=
or of encrypt.format=3Daes)
> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passphras=
e
> -encrypt.cipher-alg Name of encryption cipher algorithm
> -encrypt.cipher-mode Name of encryption cipher mode
> -encrypt.ivgen-alg Name of IV generator algorithm
> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
> -encrypt.hash-alg Name of encryption hash algorithm
> -encrypt.iter-time Time to spend in PBKDF in milliseconds
> -cluster_size     qcow2 cluster size
> -preallocation    Preallocation mode (allowed values: off, metadata, fall=
oc, full)
> -lazy_refcounts   Postpone refcount updates
> -refcount_bits    Width of a reference count entry in bits
> +  backing_file: str - File name of a base image
> +  backing_fmt: str - Image format of the base image
> +  cluster_size: size - qcow2 cluster size
> +  compat: str - Compatibility level (0.10 or 1.1)
> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
> +  encrypt.cipher-mode: str - Name of encryption cipher mode
> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'luks'
> +  encrypt.hash-alg: str - Name of encryption hash algorithm
> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LUKS =
passphrase
> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (Depr=
ecated in favor of encrypt.format=3Daes)
> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
> +  preallocation: str - Preallocation mode (allowed values: off, metadata=
, falloc, full)
> +  refcount_bits: num - Width of a reference count entry in bits
> +  size: size - Virtual disk size
>
>  Note that not all of these options may be amendable.
>
>  Testing: convert -o help
>  Supported options:
> -size             Virtual disk size
> +  size: size - Virtual disk size
>
>  Testing: amend -f bochs -o help
>  qemu-img: Format driver 'bochs' does not support option amendment
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
