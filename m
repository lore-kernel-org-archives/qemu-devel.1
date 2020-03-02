Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C8DC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770032166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMCFlrSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770032166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jL1-0005EI-K8
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jJr-0003MY-0g
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8jJm-00008t-3f
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:33:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8jJl-00007u-MH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:33:02 -0500
Received: by mail-wr1-x443.google.com with SMTP id j7so12041817wrp.13
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uTaVVYaSH/r7+1axs/Jio+5YwS3WdP8SDCFpWxeHxE4=;
 b=wMCFlrSD8/doG8FYrxlE3Opx/8huCptVXvJun9JlQY7kBRU86snI/Ima+a0QmWme8b
 jfS0VrtCkUaXFZgNvkf8tsLoxAgPvq6aWMOouT3kxpFas4JbLON1vtYbstRLdGfKCgcF
 R+9x9ZwEi/OvctA2YrBN/yulY3dEC3fMtlq+F/oJfsBV87pCBsdV7aoJkHx3es8wbTPh
 bCakLe6bi8pu5BFqLDPIsO3eowUFJ80vOHGuZHrlr2kNnIi+1J+I5hYFezE6rLPq8Ym3
 9h2mA8AtyQJrQVDvQS7HpZcSuV6gedcg5SWnmiiWVQ8ufzYgOrC67lhvj8JhxYDHRHT4
 kNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uTaVVYaSH/r7+1axs/Jio+5YwS3WdP8SDCFpWxeHxE4=;
 b=OubcUtrmZfLrflM63gJESeOwg5xvDNwqRTEdr7DpBQAmBegV3dvK4rCcB7KaP/pMZN
 avbRdyWfQJxGLAzUqZo9NyXkuMIg7PqDN0WtBayRWpbK/yETmpiKobCN7t+Kf4TMZSCq
 5C6j0moYmiaUZX2aTMObte6U+ftt1SvdUsGGFlKCXN9hQ1ftCylbrt22ojxHdJua1bX6
 r5nor2w5JEKNwfZYrYMlEmBLK+CBV26eLw/9islwJldvtw4Pphii3K+DDvhdwVTdiGId
 kzPB8G3nH8D1i3ESvs5QcXm2Lfb/YK+EHLWa84plJbXmLKn3sXCZebdB2RIdIo6IZg+z
 83rA==
X-Gm-Message-State: ANhLgQ34vBLIW1vkKhi66xMeV7f35Us44KHFM5x4d0FcZAkZCT0a4c3v
 Z7jfDEtpKFizEFJ9jFphAyJQGw==
X-Google-Smtp-Source: ADFU+vtK4fI21Ff73mhm4ls/Ynyh8KkXbTQji78uN7uuMdOUpVJphvgTlyc8Xcs7rnfNJcb/RFcNQQ==
X-Received: by 2002:a5d:4752:: with SMTP id o18mr12365568wrs.267.1583148779655; 
 Mon, 02 Mar 2020 03:32:59 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r1sm26227774wrx.11.2020.03.02.03.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 03:32:58 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8AA651FF87;
 Mon,  2 Mar 2020 11:32:57 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-14-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 13/33] docs/system: put qemu-block-drivers body in an
 included file
In-reply-to: <20200228153619.9906-14-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 11:32:57 +0000
Message-ID: <87d09vat5i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> This removes the "only" directives, and lets us use the conventional
> "DESCRIPTION" section in the manpage.
>
> This temporarily drops the qemu-block-drivers documentation
> from the system manual, but it will be put back (in the
> right place in the toctree) in a later commit.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200226113034.6741-14-pbonzini@redhat.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> [PMM: Added commit message note about temporarily losing
> qemu-block-drivers from the system manual]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  docs/system/index.rst                         |   1 -
>  docs/system/qemu-block-drivers.rst            | 987 +-----------------
>  ...drivers.rst =3D> qemu-block-drivers.rst.inc} |  59 +-
>  3 files changed, 26 insertions(+), 1021 deletions(-)
>  copy docs/system/{qemu-block-drivers.rst =3D> qemu-block-drivers.rst.inc=
} (96%)
>
> diff --git a/docs/system/index.rst b/docs/system/index.rst
> index 1a4b2c82ace..fc774a18b54 100644
> --- a/docs/system/index.rst
> +++ b/docs/system/index.rst
> @@ -14,5 +14,4 @@ Contents:
>  .. toctree::
>     :maxdepth: 2
>=20=20
> -   qemu-block-drivers
>     vfio-ap
> diff --git a/docs/system/qemu-block-drivers.rst b/docs/system/qemu-block-=
drivers.rst
> index 388adbefbf4..7ca890ea23a 100644
> --- a/docs/system/qemu-block-drivers.rst
> +++ b/docs/system/qemu-block-drivers.rst
> @@ -1,985 +1,22 @@
> +:orphan:
> +
>  QEMU block drivers reference
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20=20
>  .. |qemu_system| replace:: qemu-system-x86_64
>=20=20
> -..
> -   We put the 'Synopsis' and 'See also' sections into the manpage, but n=
ot
> -   the HTML. This makes the HTML docs read better and means the ToC in
> -   the index has a more useful set of entries. Ideally, the section
> -   headings 'Disk image file formats' would be top-level headings for
> -   the HTML, but sub-headings of the conventional manpage 'Description'
> -   header for the manpage. Unfortunately, due to deficiencies in
> -   the Sphinx 'only' directive, this isn't possible: they must be headers
> -   at the same level as 'Synopsis' and 'See also', otherwise Sphinx's
> -   identification of which header underline style is which gets confused.
> +Synopsis
> +--------
>=20=20
> -.. only:: man
> +QEMU block driver reference manual
>=20=20
> -  Synopsis
> -  --------
> +Description
> +-----------
>=20=20
> -  QEMU block driver reference manual
> +.. include:: qemu-block-drivers.rst.inc
>=20=20
> -Disk image file formats
> ------------------------
> +See also
> +--------
>=20=20
> -QEMU supports many image file formats that can be used with VMs as well =
as with
> -any of the tools (like ``qemu-img``). This includes the preferred formats
> -raw and qcow2 as well as formats that are supported for compatibility wi=
th
> -older QEMU versions or other hypervisors.
> -
> -Depending on the image format, different options can be passed to
> -``qemu-img create`` and ``qemu-img convert`` using the ``-o`` option.
> -This section describes each format and the options that are supported fo=
r it.
> -
> -.. program:: image-formats
> -.. option:: raw
> -
> -  Raw disk image format. This format has the advantage of
> -  being simple and easily exportable to all other emulators. If your
> -  file system supports *holes* (for example in ext2 or ext3 on
> -  Linux or NTFS on Windows), then only the written sectors will reserve
> -  space. Use ``qemu-img info`` to know the real size used by the
> -  image or ``ls -ls`` on Unix/Linux.
> -
> -  Supported options:
> -
> -  .. program:: raw
> -  .. option:: preallocation
> -
> -    Preallocation mode (allowed values: ``off``, ``falloc``,
> -    ``full``). ``falloc`` mode preallocates space for image by
> -    calling ``posix_fallocate()``. ``full`` mode preallocates space
> -    for image by writing data to underlying storage. This data may or
> -    may not be zero, depending on the storage location.
> -
> -.. program:: image-formats
> -.. option:: qcow2
> -
> -  QEMU image format, the most versatile format. Use it to have smaller
> -  images (useful if your filesystem does not supports holes, for example
> -  on Windows), zlib based compression and support of multiple VM
> -  snapshots.
> -
> -  Supported options:
> -
> -  .. program:: qcow2
> -  .. option:: compat
> -
> -    Determines the qcow2 version to use. ``compat=3D0.10`` uses the
> -    traditional image format that can be read by any QEMU since 0.10.
> -    ``compat=3D1.1`` enables image format extensions that only QEMU 1.1 =
and
> -    newer understand (this is the default). Amongst others, this includes
> -    zero clusters, which allow efficient copy-on-read for sparse images.
> -
> -  .. option:: backing_file
> -
> -    File name of a base image (see ``create`` subcommand)
> -
> -  .. option:: backing_fmt
> -
> -    Image format of the base image
> -
> -  .. option:: encryption
> -
> -    This option is deprecated and equivalent to ``encrypt.format=3Daes``
> -
> -  .. option:: encrypt.format
> -
> -    If this is set to ``luks``, it requests that the qcow2 payload (not
> -    qcow2 header) be encrypted using the LUKS format. The passphrase to
> -    use to unlock the LUKS key slot is given by the ``encrypt.key-secret=
``
> -    parameter. LUKS encryption parameters can be tuned with the other
> -    ``encrypt.*`` parameters.
> -
> -    If this is set to ``aes``, the image is encrypted with 128-bit AES-C=
BC.
> -    The encryption key is given by the ``encrypt.key-secret`` parameter.
> -    This encryption format is considered to be flawed by modern cryptogr=
aphy
> -    standards, suffering from a number of design problems:
> -
> -    - The AES-CBC cipher is used with predictable initialization vectors=
 based
> -      on the sector number. This makes it vulnerable to chosen plaintext=
 attacks
> -      which can reveal the existence of encrypted data.
> -    - The user passphrase is directly used as the encryption key. A poor=
ly
> -      chosen or short passphrase will compromise the security of the enc=
ryption.
> -    - In the event of the passphrase being compromised there is no way to
> -      change the passphrase to protect data in any qcow images. The file=
s must
> -      be cloned, using a different encryption passphrase in the new file=
. The
> -      original file must then be securely erased using a program like sh=
red,
> -      though even this is ineffective with many modern storage technolog=
ies.
> -
> -    The use of this is no longer supported in system emulators. Support =
only
> -    remains in the command line utilities, for the purposes of data libe=
ration
> -    and interoperability with old versions of QEMU. The ``luks`` format
> -    should be used instead.
> -
> -  .. option:: encrypt.key-secret
> -
> -    Provides the ID of a ``secret`` object that contains the passphrase
> -    (``encrypt.format=3Dluks``) or encryption key (``encrypt.format=3Dae=
s``).
> -
> -  .. option:: encrypt.cipher-alg
> -
> -    Name of the cipher algorithm and key length. Currently defaults
> -    to ``aes-256``. Only used when ``encrypt.format=3Dluks``.
> -
> -  .. option:: encrypt.cipher-mode
> -
> -    Name of the encryption mode to use. Currently defaults to ``xts``.
> -    Only used when ``encrypt.format=3Dluks``.
> -
> -  .. option:: encrypt.ivgen-alg
> -
> -    Name of the initialization vector generator algorithm. Currently def=
aults
> -    to ``plain64``. Only used when ``encrypt.format=3Dluks``.
> -
> -  .. option:: encrypt.ivgen-hash-alg
> -
> -    Name of the hash algorithm to use with the initialization vector gen=
erator
> -    (if required). Defaults to ``sha256``. Only used when ``encrypt.form=
at=3Dluks``.
> -
> -  .. option:: encrypt.hash-alg
> -
> -    Name of the hash algorithm to use for PBKDF algorithm
> -    Defaults to ``sha256``. Only used when ``encrypt.format=3Dluks``.
> -
> -  .. option:: encrypt.iter-time
> -
> -    Amount of time, in milliseconds, to use for PBKDF algorithm per key =
slot.
> -    Defaults to ``2000``. Only used when ``encrypt.format=3Dluks``.
> -
> -  .. option:: cluster_size
> -
> -    Changes the qcow2 cluster size (must be between 512 and 2M). Smaller=
 cluster
> -    sizes can improve the image file size whereas larger cluster sizes g=
enerally
> -    provide better performance.
> -
> -  .. option:: preallocation
> -
> -    Preallocation mode (allowed values: ``off``, ``metadata``, ``falloc`=
`,
> -    ``full``). An image with preallocated metadata is initially larger b=
ut can
> -    improve performance when the image needs to grow. ``falloc`` and ``f=
ull``
> -    preallocations are like the same options of ``raw`` format, but sets=
 up
> -    metadata also.
> -
> -  .. option:: lazy_refcounts
> -
> -    If this option is set to ``on``, reference count updates are postpon=
ed with
> -    the goal of avoiding metadata I/O and improving performance. This is
> -    particularly interesting with :option:`cache=3Dwritethrough` which d=
oesn't batch
> -    metadata updates. The tradeoff is that after a host crash, the refer=
ence count
> -    tables must be rebuilt, i.e. on the next open an (automatic) ``qemu-=
img
> -    check -r all`` is required, which may take some time.
> -
> -    This option can only be enabled if ``compat=3D1.1`` is specified.
> -
> -  .. option:: nocow
> -
> -    If this option is set to ``on``, it will turn off COW of the file. I=
t's only
> -    valid on btrfs, no effect on other file systems.
> -
> -    Btrfs has low performance when hosting a VM image file, even more
> -    when the guest on the VM also using btrfs as file system. Turning off
> -    COW is a way to mitigate this bad performance. Generally there are t=
wo
> -    ways to turn off COW on btrfs:
> -
> -    - Disable it by mounting with nodatacow, then all newly created files
> -      will be NOCOW.
> -    - For an empty file, add the NOCOW file attribute. That's what this
> -      option does.
> -
> -    Note: this option is only valid to new or empty files. If there is
> -    an existing file which is COW and has data blocks already, it couldn=
't
> -    be changed to NOCOW by setting ``nocow=3Don``. One can issue ``lsattr
> -    filename`` to check if the NOCOW flag is set or not (Capital 'C' is
> -    NOCOW flag).
> -
> -.. program:: image-formats
> -.. option:: qed
> -
> -   Old QEMU image format with support for backing files and compact imag=
e files
> -   (when your filesystem or transport medium does not support holes).
> -
> -   When converting QED images to qcow2, you might want to consider using=
 the
> -   ``lazy_refcounts=3Don`` option to get a more QED-like behaviour.
> -
> -   Supported options:
> -
> -   .. program:: qed
> -   .. option:: backing_file
> -
> -      File name of a base image (see ``create`` subcommand).
> -
> -   .. option:: backing_fmt
> -
> -     Image file format of backing file (optional).  Useful if the format=
 cannot be
> -     autodetected because it has no header, like some vhd/vpc files.
> -
> -   .. option:: cluster_size
> -
> -     Changes the cluster size (must be power-of-2 between 4K and 64K). S=
maller
> -     cluster sizes can improve the image file size whereas larger cluste=
r sizes
> -     generally provide better performance.
> -
> -   .. option:: table_size
> -
> -     Changes the number of clusters per L1/L2 table (must be
> -     power-of-2 between 1 and 16).  There is normally no need to
> -     change this value but this option can between used for
> -     performance benchmarking.
> -
> -.. program:: image-formats
> -.. option:: qcow
> -
> -  Old QEMU image format with support for backing files, compact image fi=
les,
> -  encryption and compression.
> -
> -  Supported options:
> -
> -   .. program:: qcow
> -   .. option:: backing_file
> -
> -     File name of a base image (see ``create`` subcommand)
> -
> -   .. option:: encryption
> -
> -     This option is deprecated and equivalent to ``encrypt.format=3Daes``
> -
> -   .. option:: encrypt.format
> -
> -     If this is set to ``aes``, the image is encrypted with 128-bit AES-=
CBC.
> -     The encryption key is given by the ``encrypt.key-secret`` parameter.
> -     This encryption format is considered to be flawed by modern cryptog=
raphy
> -     standards, suffering from a number of design problems enumerated pr=
eviously
> -     against the ``qcow2`` image format.
> -
> -     The use of this is no longer supported in system emulators. Support=
 only
> -     remains in the command line utilities, for the purposes of data lib=
eration
> -     and interoperability with old versions of QEMU.
> -
> -     Users requiring native encryption should use the ``qcow2`` format
> -     instead with ``encrypt.format=3Dluks``.
> -
> -   .. option:: encrypt.key-secret
> -
> -     Provides the ID of a ``secret`` object that contains the encryption
> -     key (``encrypt.format=3Daes``).
> -
> -.. program:: image-formats
> -.. option:: luks
> -
> -  LUKS v1 encryption format, compatible with Linux dm-crypt/cryptsetup
> -
> -  Supported options:
> -
> -  .. program:: luks
> -  .. option:: key-secret
> -
> -    Provides the ID of a ``secret`` object that contains the passphrase.
> -
> -  .. option:: cipher-alg
> -
> -    Name of the cipher algorithm and key length. Currently defaults
> -    to ``aes-256``.
> -
> -  .. option:: cipher-mode
> -
> -    Name of the encryption mode to use. Currently defaults to ``xts``.
> -
> -  .. option:: ivgen-alg
> -
> -    Name of the initialization vector generator algorithm. Currently def=
aults
> -    to ``plain64``.
> -
> -  .. option:: ivgen-hash-alg
> -
> -    Name of the hash algorithm to use with the initialization vector gen=
erator
> -    (if required). Defaults to ``sha256``.
> -
> -  .. option:: hash-alg
> -
> -    Name of the hash algorithm to use for PBKDF algorithm
> -    Defaults to ``sha256``.
> -
> -  .. option:: iter-time
> -
> -    Amount of time, in milliseconds, to use for PBKDF algorithm per key =
slot.
> -    Defaults to ``2000``.
> -
> -.. program:: image-formats
> -.. option:: vdi
> -
> -  VirtualBox 1.1 compatible image format.
> -
> -  Supported options:
> -
> -  .. program:: vdi
> -  .. option:: static
> -
> -    If this option is set to ``on``, the image is created with metadata
> -    preallocation.
> -
> -.. program:: image-formats
> -.. option:: vmdk
> -
> -  VMware 3 and 4 compatible image format.
> -
> -  Supported options:
> -
> -  .. program: vmdk
> -  .. option:: backing_file
> -
> -    File name of a base image (see ``create`` subcommand).
> -
> -  .. option:: compat6
> -
> -    Create a VMDK version 6 image (instead of version 4)
> -
> -  .. option:: hwversion
> -
> -    Specify vmdk virtual hardware version. Compat6 flag cannot be enabled
> -    if hwversion is specified.
> -
> -  .. option:: subformat
> -
> -    Specifies which VMDK subformat to use. Valid options are
> -    ``monolithicSparse`` (default),
> -    ``monolithicFlat``,
> -    ``twoGbMaxExtentSparse``,
> -    ``twoGbMaxExtentFlat`` and
> -    ``streamOptimized``.
> -
> -.. program:: image-formats
> -.. option:: vpc
> -
> -  VirtualPC compatible image format (VHD).
> -
> -  Supported options:
> -
> -  .. program:: vpc
> -  .. option:: subformat
> -
> -    Specifies which VHD subformat to use. Valid options are
> -    ``dynamic`` (default) and ``fixed``.
> -
> -.. program:: image-formats
> -.. option:: VHDX
> -
> -  Hyper-V compatible image format (VHDX).
> -
> -  Supported options:
> -
> -  .. program:: VHDX
> -  .. option:: subformat
> -
> -    Specifies which VHDX subformat to use. Valid options are
> -    ``dynamic`` (default) and ``fixed``.
> -
> -    .. option:: block_state_zero
> -
> -      Force use of payload blocks of type 'ZERO'.  Can be set to ``on`` =
(default)
> -      or ``off``.  When set to ``off``, new blocks will be created as
> -      ``PAYLOAD_BLOCK_NOT_PRESENT``, which means parsers are free to ret=
urn
> -      arbitrary data for those blocks.  Do not set to ``off`` when using
> -      ``qemu-img convert`` with ``subformat=3Ddynamic``.
> -
> -    .. option:: block_size
> -
> -      Block size; min 1 MB, max 256 MB.  0 means auto-calculate based on
> -      image size.
> -
> -    .. option:: log_size
> -
> -      Log size; min 1 MB.
> -
> -Read-only formats
> ------------------
> -
> -More disk image file formats are supported in a read-only mode.
> -
> -.. program:: image-formats
> -.. option:: bochs
> -
> -  Bochs images of ``growing`` type.
> -
> -.. program:: image-formats
> -.. option:: cloop
> -
> -  Linux Compressed Loop image, useful only to reuse directly compressed
> -  CD-ROM images present for example in the Knoppix CD-ROMs.
> -
> -.. program:: image-formats
> -.. option:: dmg
> -
> -  Apple disk image.
> -
> -.. program:: image-formats
> -.. option:: parallels
> -
> -  Parallels disk image format.
> -
> -Using host drives
> ------------------
> -
> -In addition to disk image files, QEMU can directly access host
> -devices. We describe here the usage for QEMU version >=3D 0.8.3.
> -
> -Linux
> -'''''
> -
> -On Linux, you can directly use the host device filename instead of a
> -disk image filename provided you have enough privileges to access
> -it. For example, use ``/dev/cdrom`` to access to the CDROM.
> -
> -CD
> -  You can specify a CDROM device even if no CDROM is loaded. QEMU has
> -  specific code to detect CDROM insertion or removal. CDROM ejection by
> -  the guest OS is supported. Currently only data CDs are supported.
> -
> -Floppy
> -  You can specify a floppy device even if no floppy is loaded. Floppy
> -  removal is currently not detected accurately (if you change floppy
> -  without doing floppy access while the floppy is not loaded, the guest
> -  OS will think that the same floppy is loaded).
> -  Use of the host's floppy device is deprecated, and support for it will
> -  be removed in a future release.
> -
> -Hard disks
> -  Hard disks can be used. Normally you must specify the whole disk
> -  (``/dev/hdb`` instead of ``/dev/hdb1``) so that the guest OS can
> -  see it as a partitioned disk. WARNING: unless you know what you do, it
> -  is better to only make READ-ONLY accesses to the hard disk otherwise
> -  you may corrupt your host data (use the ``-snapshot`` command
> -  line option or modify the device permissions accordingly).
> -
> -Windows
> -'''''''
> -
> -CD
> -  The preferred syntax is the drive letter (e.g. ``d:``). The
> -  alternate syntax ``\\.\d:`` is supported. ``/dev/cdrom`` is
> -  supported as an alias to the first CDROM drive.
> -
> -  Currently there is no specific code to handle removable media, so it
> -  is better to use the ``change`` or ``eject`` monitor commands to
> -  change or eject media.
> -
> -Hard disks
> -  Hard disks can be used with the syntax: ``\\.\PhysicalDriveN``
> -  where *N* is the drive number (0 is the first hard disk).
> -
> -  WARNING: unless you know what you do, it is better to only make
> -  READ-ONLY accesses to the hard disk otherwise you may corrupt your
> -  host data (use the ``-snapshot`` command line so that the
> -  modifications are written in a temporary file).
> -
> -Mac OS X
> -''''''''
> -
> -``/dev/cdrom`` is an alias to the first CDROM.
> -
> -Currently there is no specific code to handle removable media, so it
> -is better to use the ``change`` or ``eject`` monitor commands to
> -change or eject media.
> -
> -Virtual FAT disk images
> ------------------------
> -
> -QEMU can automatically create a virtual FAT disk image from a
> -directory tree. In order to use it, just type:
> -
> -.. parsed-literal::
> -
> -  |qemu_system| linux.img -hdb fat:/my_directory
> -
> -Then you access access to all the files in the ``/my_directory``
> -directory without having to copy them in a disk image or to export
> -them via SAMBA or NFS. The default access is *read-only*.
> -
> -Floppies can be emulated with the ``:floppy:`` option:
> -
> -.. parsed-literal::
> -
> -  |qemu_system| linux.img -fda fat:floppy:/my_directory
> -
> -A read/write support is available for testing (beta stage) with the
> -``:rw:`` option:
> -
> -.. parsed-literal::
> -
> -  |qemu_system| linux.img -fda fat:floppy:rw:/my_directory
> -
> -What you should *never* do:
> -
> -- use non-ASCII filenames
> -- use "-snapshot" together with ":rw:"
> -- expect it to work when loadvm'ing
> -- write to the FAT directory on the host system while accessing it with =
the guest system
> -
> -NBD access
> -----------
> -
> -QEMU can access directly to block device exported using the Network Bloc=
k Device
> -protocol.
> -
> -.. parsed-literal::
> -
> -  |qemu_system| linux.img -hdb nbd://my_nbd_server.mydomain.org:1024/
> -
> -If the NBD server is located on the same host, you can use an unix socke=
t instead
> -of an inet socket:
> -
> -.. parsed-literal::
> -
> -  |qemu_system| linux.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> -
> -In this case, the block device must be exported using qemu-nbd:
> -
> -.. parsed-literal::
> -
> -  qemu-nbd --socket=3D/tmp/my_socket my_disk.qcow2
> -
> -The use of qemu-nbd allows sharing of a disk between several guests:
> -
> -.. parsed-literal::
> -
> -  qemu-nbd --socket=3D/tmp/my_socket --share=3D2 my_disk.qcow2
> -
> -and then you can use it with two guests:
> -
> -.. parsed-literal::
> -
> -  |qemu_system| linux1.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> -  |qemu_system| linux2.img -hdb nbd+unix://?socket=3D/tmp/my_socket
> -
> -If the nbd-server uses named exports (supported since NBD 2.9.18, or wit=
h QEMU's
> -own embedded NBD server), you must specify an export name in the URI:
> -
> -.. parsed-literal::
> -
> -  |qemu_system| -cdrom nbd://localhost/debian-500-ppc-netinst
> -  |qemu_system| -cdrom nbd://localhost/openSUSE-11.1-ppc-netinst
> -
> -The URI syntax for NBD is supported since QEMU 1.3.  An alternative synt=
ax is
> -also available.  Here are some example of the older syntax:
> -
> -.. parsed-literal::
> -
> -  |qemu_system| linux.img -hdb nbd:my_nbd_server.mydomain.org:1024
> -  |qemu_system| linux2.img -hdb nbd:unix:/tmp/my_socket
> -  |qemu_system| -cdrom nbd:localhost:10809:exportname=3Ddebian-500-ppc-n=
etinst
> -
> -
> -
> -Sheepdog disk images
> ---------------------
> -
> -Sheepdog is a distributed storage system for QEMU.  It provides highly
> -available block level storage volumes that can be attached to
> -QEMU-based virtual machines.
> -
> -You can create a Sheepdog disk image with the command:
> -
> -.. parsed-literal::
> -
> -  qemu-img create sheepdog:///IMAGE SIZE
> -
> -where *IMAGE* is the Sheepdog image name and *SIZE* is its
> -size.
> -
> -To import the existing *FILENAME* to Sheepdog, you can use a
> -convert command.
> -
> -.. parsed-literal::
> -
> -  qemu-img convert FILENAME sheepdog:///IMAGE
> -
> -You can boot from the Sheepdog disk image with the command:
> -
> -.. parsed-literal::
> -
> -  |qemu_system| sheepdog:///IMAGE
> -
> -You can also create a snapshot of the Sheepdog image like qcow2.
> -
> -.. parsed-literal::
> -
> -  qemu-img snapshot -c TAG sheepdog:///IMAGE
> -
> -where *TAG* is a tag name of the newly created snapshot.
> -
> -To boot from the Sheepdog snapshot, specify the tag name of the
> -snapshot.
> -
> -.. parsed-literal::
> -
> -  |qemu_system| sheepdog:///IMAGE#TAG
> -
> -You can create a cloned image from the existing snapshot.
> -
> -.. parsed-literal::
> -
> -  qemu-img create -b sheepdog:///BASE#TAG sheepdog:///IMAGE
> -
> -where *BASE* is an image name of the source snapshot and *TAG*
> -is its tag name.
> -
> -You can use an unix socket instead of an inet socket:
> -
> -.. parsed-literal::
> -
> -  |qemu_system| sheepdog+unix:///IMAGE?socket=3DPATH
> -
> -If the Sheepdog daemon doesn't run on the local host, you need to
> -specify one of the Sheepdog servers to connect to.
> -
> -.. parsed-literal::
> -
> -  qemu-img create sheepdog://HOSTNAME:PORT/IMAGE SIZE
> -  |qemu_system| sheepdog://HOSTNAME:PORT/IMAGE
> -
> -iSCSI LUNs
> -----------
> -
> -iSCSI is a popular protocol used to access SCSI devices across a computer
> -network.
> -
> -There are two different ways iSCSI devices can be used by QEMU.
> -
> -The first method is to mount the iSCSI LUN on the host, and make it appe=
ar as
> -any other ordinary SCSI device on the host and then to access this devic=
e as a
> -/dev/sd device from QEMU. How to do this differs between host OSes.
> -
> -The second method involves using the iSCSI initiator that is built into
> -QEMU. This provides a mechanism that works the same way regardless of wh=
ich
> -host OS you are running QEMU on. This section will describe this second =
method
> -of using iSCSI together with QEMU.
> -
> -In QEMU, iSCSI devices are described using special iSCSI URLs. URL synta=
x:
> -
> -::
> -
> -  iscsi://[<username>[%<password>]@]<host>[:<port>]/<target-iqn-name>/<l=
un>
> -
> -Username and password are optional and only used if your target is set up
> -using CHAP authentication for access control.
> -Alternatively the username and password can also be set via environment
> -variables to have these not show up in the process list:
> -
> -::
> -
> -  export LIBISCSI_CHAP_USERNAME=3D<username>
> -  export LIBISCSI_CHAP_PASSWORD=3D<password>
> -  iscsi://<host>/<target-iqn-name>/<lun>
> -
> -Various session related parameters can be set via special options, either
> -in a configuration file provided via '-readconfig' or directly on the
> -command line.
> -
> -If the initiator-name is not specified qemu will use a default name
> -of 'iqn.2008-11.org.linux-kvm[:<uuid>'] where <uuid> is the UUID of the
> -virtual machine. If the UUID is not specified qemu will use
> -'iqn.2008-11.org.linux-kvm[:<name>'] where <name> is the name of the
> -virtual machine.
> -
> -Setting a specific initiator name to use when logging in to the target:
> -
> -::
> -
> -  -iscsi initiator-name=3Diqn.qemu.test:my-initiator
> -
> -Controlling which type of header digest to negotiate with the target:
> -
> -::
> -
> -  -iscsi header-digest=3DCRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> -
> -These can also be set via a configuration file:
> -
> -::
> -
> -  [iscsi]
> -    user =3D "CHAP username"
> -    password =3D "CHAP password"
> -    initiator-name =3D "iqn.qemu.test:my-initiator"
> -    # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> -    header-digest =3D "CRC32C"
> -
> -Setting the target name allows different options for different targets:
> -
> -::
> -
> -  [iscsi "iqn.target.name"]
> -    user =3D "CHAP username"
> -    password =3D "CHAP password"
> -    initiator-name =3D "iqn.qemu.test:my-initiator"
> -    # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
> -    header-digest =3D "CRC32C"
> -
> -How to use a configuration file to set iSCSI configuration options:
> -
> -.. parsed-literal::
> -
> -  cat >iscsi.conf <<EOF
> -  [iscsi]
> -    user =3D "me"
> -    password =3D "my password"
> -    initiator-name =3D "iqn.qemu.test:my-initiator"
> -    header-digest =3D "CRC32C"
> -  EOF
> -
> -  |qemu_system| -drive file=3Discsi://127.0.0.1/iqn.qemu.test/1 \\
> -    -readconfig iscsi.conf
> -
> -How to set up a simple iSCSI target on loopback and access it via QEMU:
> -this example shows how to set up an iSCSI target with one CDROM and one =
DISK
> -using the Linux STGT software target. This target is available on Red Ha=
t based
> -systems as the package 'scsi-target-utils'.
> -
> -.. parsed-literal::
> -
> -  tgtd --iscsi portal=3D127.0.0.1:3260
> -  tgtadm --lld iscsi --op new --mode target --tid 1 -T iqn.qemu.test
> -  tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 1 \\
> -      -b /IMAGES/disk.img --device-type=3Ddisk
> -  tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 2 \\
> -      -b /IMAGES/cd.iso --device-type=3Dcd
> -  tgtadm --lld iscsi --op bind --mode target --tid 1 -I ALL
> -
> -  |qemu_system| -iscsi initiator-name=3Diqn.qemu.test:my-initiator \\
> -    -boot d -drive file=3Discsi://127.0.0.1/iqn.qemu.test/1 \\
> -    -cdrom iscsi://127.0.0.1/iqn.qemu.test/2
> -
> -GlusterFS disk images
> ----------------------
> -
> -GlusterFS is a user space distributed file system.
> -
> -You can boot from the GlusterFS disk image with the command:
> -
> -URI:
> -
> -.. parsed-literal::
> -
> -  |qemu_system| -drive file=3Dgluster[+TYPE]://[HOST}[:PORT]]/VOLUME/PATH
> -                               [?socket=3D...][,file.debug=3D9][,file.lo=
gfile=3D...]
> -
> -JSON:
> -
> -.. parsed-literal::
> -
> -  |qemu_system| 'json:{"driver":"qcow2",
> -                           "file":{"driver":"gluster",
> -                                    "volume":"testvol","path":"a.img","d=
ebug":9,"logfile":"...",
> -                                    "server":[{"type":"tcp","host":"..."=
,"port":"..."},
> -                                              {"type":"unix","socket":".=
.."}]}}'
> -
> -*gluster* is the protocol.
> -
> -*TYPE* specifies the transport type used to connect to gluster
> -management daemon (glusterd). Valid transport types are
> -tcp and unix. In the URI form, if a transport type isn't specified,
> -then tcp type is assumed.
> -
> -*HOST* specifies the server where the volume file specification for
> -the given volume resides. This can be either a hostname or an ipv4 addre=
ss.
> -If transport type is unix, then *HOST* field should not be specified.
> -Instead *socket* field needs to be populated with the path to unix domain
> -socket.
> -
> -*PORT* is the port number on which glusterd is listening. This is option=
al
> -and if not specified, it defaults to port 24007. If the transport type i=
s unix,
> -then *PORT* should not be specified.
> -
> -*VOLUME* is the name of the gluster volume which contains the disk image.
> -
> -*PATH* is the path to the actual disk image that resides on gluster volu=
me.
> -
> -*debug* is the logging level of the gluster protocol driver. Debug levels
> -are 0-9, with 9 being the most verbose, and 0 representing no debugging =
output.
> -The default level is 4. The current logging levels defined in the gluste=
r source
> -are 0 - None, 1 - Emergency, 2 - Alert, 3 - Critical, 4 - Error, 5 - War=
ning,
> -6 - Notice, 7 - Info, 8 - Debug, 9 - Trace
> -
> -*logfile* is a commandline option to mention log file path which helps in
> -logging to the specified file and also help in persisting the gfapi logs=
. The
> -default is stderr.
> -
> -You can create a GlusterFS disk image with the command:
> -
> -.. parsed-literal::
> -
> -  qemu-img create gluster://HOST/VOLUME/PATH SIZE
> -
> -Examples
> -
> -.. parsed-literal::
> -
> -  |qemu_system| -drive file=3Dgluster://1.2.3.4/testvol/a.img
> -  |qemu_system| -drive file=3Dgluster+tcp://1.2.3.4/testvol/a.img
> -  |qemu_system| -drive file=3Dgluster+tcp://1.2.3.4:24007/testvol/dir/a.=
img
> -  |qemu_system| -drive file=3Dgluster+tcp://[1:2:3:4:5:6:7:8]/testvol/di=
r/a.img
> -  |qemu_system| -drive file=3Dgluster+tcp://[1:2:3:4:5:6:7:8]:24007/test=
vol/dir/a.img
> -  |qemu_system| -drive file=3Dgluster+tcp://server.domain.com:24007/test=
vol/dir/a.img
> -  |qemu_system| -drive file=3Dgluster+unix:///testvol/dir/a.img?socket=
=3D/tmp/glusterd.socket
> -  |qemu_system| -drive file=3Dgluster+rdma://1.2.3.4:24007/testvol/a.img
> -  |qemu_system| -drive file=3Dgluster://1.2.3.4/testvol/a.img,file.debug=
=3D9,file.logfile=3D/var/log/qemu-gluster.log
> -  |qemu_system| 'json:{"driver":"qcow2",
> -                           "file":{"driver":"gluster",
> -                                    "volume":"testvol","path":"a.img",
> -                                    "debug":9,"logfile":"/var/log/qemu-g=
luster.log",
> -                                    "server":[{"type":"tcp","host":"1.2.=
3.4","port":24007},
> -                                              {"type":"unix","socket":"/=
var/run/glusterd.socket"}]}}'
> -  |qemu_system| -drive driver=3Dqcow2,file.driver=3Dgluster,file.volume=
=3Dtestvol,file.path=3D/path/a.img,
> -                                       file.debug=3D9,file.logfile=3D/va=
r/log/qemu-gluster.log,
> -                                       file.server.0.type=3Dtcp,file.ser=
ver.0.host=3D1.2.3.4,file.server.0.port=3D24007,
> -                                       file.server.1.type=3Dunix,file.se=
rver.1.socket=3D/var/run/glusterd.socket
> -
> -Secure Shell (ssh) disk images
> -------------------------------
> -
> -You can access disk images located on a remote ssh server
> -by using the ssh protocol:
> -
> -.. parsed-literal::
> -
> -  |qemu_system| -drive file=3Dssh://[USER@]SERVER[:PORT]/PATH[?host_key_=
check=3DHOST_KEY_CHECK]
> -
> -Alternative syntax using properties:
> -
> -.. parsed-literal::
> -
> -  |qemu_system| -drive file.driver=3Dssh[,file.user=3DUSER],file.host=3D=
SERVER[,file.port=3DPORT],file.path=3DPATH[,file.host_key_check=3DHOST_KEY_=
CHECK]
> -
> -*ssh* is the protocol.
> -
> -*USER* is the remote user.  If not specified, then the local
> -username is tried.
> -
> -*SERVER* specifies the remote ssh server.  Any ssh server can be
> -used, but it must implement the sftp-server protocol.  Most Unix/Linux
> -systems should work without requiring any extra configuration.
> -
> -*PORT* is the port number on which sshd is listening.  By default
> -the standard ssh port (22) is used.
> -
> -*PATH* is the path to the disk image.
> -
> -The optional *HOST_KEY_CHECK* parameter controls how the remote
> -host's key is checked.  The default is ``yes`` which means to use
> -the local ``.ssh/known_hosts`` file.  Setting this to ``no``
> -turns off known-hosts checking.  Or you can check that the host key
> -matches a specific fingerprint:
> -``host_key_check=3Dmd5:78:45:8e:14:57:4f:d5:45:83:0a:0e:f3:49:82:c9:c8``
> -(``sha1:`` can also be used as a prefix, but note that OpenSSH
> -tools only use MD5 to print fingerprints).
> -
> -Currently authentication must be done using ssh-agent.  Other
> -authentication methods may be supported in future.
> -
> -Note: Many ssh servers do not support an ``fsync``-style operation.
> -The ssh driver cannot guarantee that disk flush requests are
> -obeyed, and this causes a risk of disk corruption if the remote
> -server or network goes down during writes.  The driver will
> -print a warning when ``fsync`` is not supported:
> -
> -::
> -
> -  warning: ssh server ssh.example.com:22 does not support fsync
> -
> -With sufficiently new versions of libssh and OpenSSH, ``fsync`` is
> -supported.
> -
> -NVMe disk images
> -----------------
> -
> -NVM Express (NVMe) storage controllers can be accessed directly by a use=
rspace
> -driver in QEMU.  This bypasses the host kernel file system and block lay=
ers
> -while retaining QEMU block layer functionalities, such as block jobs, I/O
> -throttling, image formats, etc.  Disk I/O performance is typically highe=
r than
> -with ``-drive file=3D/dev/sda`` using either thread pool or linux-aio.
> -
> -The controller will be exclusively used by the QEMU process once started=
. To be
> -able to share storage between multiple VMs and other applications on the=
 host,
> -please use the file based protocols.
> -
> -Before starting QEMU, bind the host NVMe controller to the host vfio-pci
> -driver.  For example:
> -
> -.. parsed-literal::
> -
> -  # modprobe vfio-pci
> -  # lspci -n -s 0000:06:0d.0
> -  06:0d.0 0401: 1102:0002 (rev 08)
> -  # echo 0000:06:0d.0 > /sys/bus/pci/devices/0000:06:0d.0/driver/unbind
> -  # echo 1102 0002 > /sys/bus/pci/drivers/vfio-pci/new_id
> -
> -  # |qemu_system| -drive file=3Dnvme://HOST:BUS:SLOT.FUNC/NAMESPACE
> -
> -Alternative syntax using properties:
> -
> -.. parsed-literal::
> -
> -  |qemu_system| -drive file.driver=3Dnvme,file.device=3DHOST:BUS:SLOT.FU=
NC,file.namespace=3DNAMESPACE
> -
> -*HOST*:*BUS*:*SLOT*.\ *FUNC* is the NVMe controller's PCI device
> -address on the host.
> -
> -*NAMESPACE* is the NVMe namespace number, starting from 1.
> -
> -Disk image file locking
> ------------------------
> -
> -By default, QEMU tries to protect image files from unexpected concurrent
> -access, as long as it's supported by the block protocol driver and host
> -operating system. If multiple QEMU processes (including QEMU emulators a=
nd
> -utilities) try to open the same image with conflicting accessing modes, =
all but
> -the first one will get an error.
> -
> -This feature is currently supported by the file protocol on Linux with t=
he Open
> -File Descriptor (OFD) locking API, and can be configured to fall back to=
 POSIX
> -locking if the POSIX host doesn't support Linux OFD locking.
> -
> -To explicitly enable image locking, specify "locking=3Don" in the file p=
rotocol
> -driver options. If OFD locking is not possible, a warning will be printe=
d and
> -the POSIX locking API will be used. In this case there is a risk that th=
e lock
> -will get silently lost when doing hot plugging and block jobs, due to the
> -shortcomings of the POSIX locking API.
> -
> -QEMU transparently handles lock handover during shared storage migration=
.  For
> -shared virtual disk images between multiple VMs, the "share-rw" device o=
ption
> -should be used.
> -
> -By default, the guest has exclusive write access to its disk image. If t=
he
> -guest can safely share the disk image with other writers the
> -``-device ...,share-rw=3Don`` parameter can be used.  This is only safe =
if
> -the guest is running software, such as a cluster file system, that
> -coordinates disk accesses to avoid corruption.
> -
> -Note that share-rw=3Don only declares the guest's ability to share the d=
isk.
> -Some QEMU features, such as image file formats, require exclusive write =
access
> -to the disk image and this is unaffected by the share-rw=3Don option.
> -
> -Alternatively, locking can be fully disabled by "locking=3Doff" block de=
vice
> -option. In the command line, the option is usually in the form of
> -"file.locking=3Doff" as the protocol driver is normally placed as a "fil=
e" child
> -under a format driver. For example:
> -
> -::
> -
> -  -blockdev driver=3Dqcow2,file.filename=3D/path/to/image,file.locking=
=3Doff,file.driver=3Dfile
> -
> -To check if image locking is active, check the output of the "lslocks" c=
ommand
> -on host and see if there are locks held by the QEMU process on the image=
 file.
> -More than one byte could be locked by the QEMU instance, each byte of wh=
ich
> -reflects a particular permission that is acquired or protected by the ru=
nning
> -block driver.
> -
> -.. only:: man
> -
> -  See also
> -  --------
> -
> -  The HTML documentation of QEMU for more precise information and Linux
> -  user mode emulator invocation.
> +The HTML documentation of QEMU for more precise information and Linux
> +user mode emulator invocation.
> diff --git a/docs/system/qemu-block-drivers.rst b/docs/system/qemu-block-=
drivers.rst.inc
> similarity index 96%
> copy from docs/system/qemu-block-drivers.rst
> copy to docs/system/qemu-block-drivers.rst.inc
> index 388adbefbf4..b052a6d14e2 100644
> --- a/docs/system/qemu-block-drivers.rst
> +++ b/docs/system/qemu-block-drivers.rst.inc
> @@ -1,28 +1,5 @@
> -QEMU block drivers reference
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -
> -.. |qemu_system| replace:: qemu-system-x86_64
> -
> -..
> -   We put the 'Synopsis' and 'See also' sections into the manpage, but n=
ot
> -   the HTML. This makes the HTML docs read better and means the ToC in
> -   the index has a more useful set of entries. Ideally, the section
> -   headings 'Disk image file formats' would be top-level headings for
> -   the HTML, but sub-headings of the conventional manpage 'Description'
> -   header for the manpage. Unfortunately, due to deficiencies in
> -   the Sphinx 'only' directive, this isn't possible: they must be headers
> -   at the same level as 'Synopsis' and 'See also', otherwise Sphinx's
> -   identification of which header underline style is which gets confused.
> -
> -.. only:: man
> -
> -  Synopsis
> -  --------
> -
> -  QEMU block driver reference manual
> -
>  Disk image file formats
> ------------------------
> +~~~~~~~~~~~~~~~~~~~~~~~
>=20=20
>  QEMU supports many image file formats that can be used with VMs as well =
as with
>  any of the tools (like ``qemu-img``). This includes the preferred formats
> @@ -394,7 +371,7 @@ This section describes each format and the options th=
at are supported for it.
>        Log size; min 1 MB.
>=20=20
>  Read-only formats
> ------------------
> +~~~~~~~~~~~~~~~~~
>=20=20
>  More disk image file formats are supported in a read-only mode.
>=20=20
> @@ -420,13 +397,13 @@ More disk image file formats are supported in a rea=
d-only mode.
>    Parallels disk image format.
>=20=20
>  Using host drives
> ------------------
> +~~~~~~~~~~~~~~~~~
>=20=20
>  In addition to disk image files, QEMU can directly access host
>  devices. We describe here the usage for QEMU version >=3D 0.8.3.
>=20=20
>  Linux
> -'''''
> +^^^^^
>=20=20
>  On Linux, you can directly use the host device filename instead of a
>  disk image filename provided you have enough privileges to access
> @@ -454,7 +431,7 @@ Hard disks
>    line option or modify the device permissions accordingly).
>=20=20
>  Windows
> -'''''''
> +^^^^^^^
>=20=20
>  CD
>    The preferred syntax is the drive letter (e.g. ``d:``). The
> @@ -475,7 +452,7 @@ Hard disks
>    modifications are written in a temporary file).
>=20=20
>  Mac OS X
> -''''''''
> +^^^^^^^^
>=20=20
>  ``/dev/cdrom`` is an alias to the first CDROM.
>=20=20
> @@ -484,7 +461,7 @@ is better to use the ``change`` or ``eject`` monitor =
commands to
>  change or eject media.
>=20=20
>  Virtual FAT disk images
> ------------------------
> +~~~~~~~~~~~~~~~~~~~~~~~
>=20=20
>  QEMU can automatically create a virtual FAT disk image from a
>  directory tree. In order to use it, just type:
> @@ -518,7 +495,7 @@ What you should *never* do:
>  - write to the FAT directory on the host system while accessing it with =
the guest system
>=20=20
>  NBD access
> -----------
> +~~~~~~~~~~
>=20=20
>  QEMU can access directly to block device exported using the Network Bloc=
k Device
>  protocol.
> @@ -573,7 +550,7 @@ also available.  Here are some example of the older s=
yntax:
>=20=20
>=20=20
>  Sheepdog disk images
> ---------------------
> +~~~~~~~~~~~~~~~~~~~~
>=20=20
>  Sheepdog is a distributed storage system for QEMU.  It provides highly
>  available block level storage volumes that can be attached to
> @@ -640,7 +617,7 @@ specify one of the Sheepdog servers to connect to.
>    |qemu_system| sheepdog://HOSTNAME:PORT/IMAGE
>=20=20
>  iSCSI LUNs
> -----------
> +~~~~~~~~~~
>=20=20
>  iSCSI is a popular protocol used to access SCSI devices across a computer
>  network.
> @@ -752,7 +729,7 @@ systems as the package 'scsi-target-utils'.
>      -cdrom iscsi://127.0.0.1/iqn.qemu.test/2
>=20=20
>  GlusterFS disk images
> ----------------------
> +~~~~~~~~~~~~~~~~~~~~~
>=20=20
>  GlusterFS is a user space distributed file system.
>=20=20
> @@ -837,7 +814,7 @@ Examples
>                                         file.server.1.type=3Dunix,file.se=
rver.1.socket=3D/var/run/glusterd.socket
>=20=20
>  Secure Shell (ssh) disk images
> -------------------------------
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20=20
>  You can access disk images located on a remote ssh server
>  by using the ssh protocol:
> @@ -892,7 +869,7 @@ With sufficiently new versions of libssh and OpenSSH,=
 ``fsync`` is
>  supported.
>=20=20
>  NVMe disk images
> -----------------
> +~~~~~~~~~~~~~~~~
>=20=20
>  NVM Express (NVMe) storage controllers can be accessed directly by a use=
rspace
>  driver in QEMU.  This bypasses the host kernel file system and block lay=
ers
> @@ -929,7 +906,7 @@ address on the host.
>  *NAMESPACE* is the NVMe namespace number, starting from 1.
>=20=20
>  Disk image file locking
> ------------------------
> +~~~~~~~~~~~~~~~~~~~~~~~
>=20=20
>  By default, QEMU tries to protect image files from unexpected concurrent
>  access, as long as it's supported by the block protocol driver and host
> @@ -975,11 +952,3 @@ on host and see if there are locks held by the QEMU =
process on the image file.
>  More than one byte could be locked by the QEMU instance, each byte of wh=
ich
>  reflects a particular permission that is acquired or protected by the ru=
nning
>  block driver.
> -
> -.. only:: man
> -
> -  See also
> -  --------
> -
> -  The HTML documentation of QEMU for more precise information and Linux
> -  user mode emulator invocation.


--=20
Alex Benn=C3=A9e

