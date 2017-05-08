Received: from eggs.gnu.org ([2001:4830:134:3::10]:58771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d7jTq-0002Ue-33
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d7jTl-0004MQ-0G
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:17:42 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:47342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1d7jTk-0004MJ-J9
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:17:36 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170418135726.28022-8-stefanha@redhat.com>
References: <20170418135726.28022-1-stefanha@redhat.com>
	<20170418135726.28022-8-stefanha@redhat.com>
Date: Mon, 08 May 2017 16:17:34 +0200
Message-ID: <w5137cf301t.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 7/9] qemu-img: add measure subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, John Snow <jsnow@redhat.com>

On Tue 18 Apr 2017 03:57:24 PM CEST, Stefan Hajnoczi wrote:
> The measure subcommand calculates the size required by a new image file.
> This can be used by users or management tools that need to allocate
> space on an LVM volume, SAN LUN, etc before creating or converting an
> image file.
>
> Suggested-by: Maor Lipchuk <mlipchuk@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v5:
>  * Use UINT64_MAX instead of ~0ULL [Berto]
>  * Document qemu-img measure ofmt, fmt, output_fmt, and snapshot_param
>    [Berto]
> ---
  [...]
> +    QemuOptsList *create_opts = NULL;
> +    bool image_opts = false;
> +    uint64_t img_size = UINT64_MAX;

You are using UINT64_MAX here, but the rest of the function still uses
~0ULL.

> +        case OPTION_SIZE:
> +        {
> +            int64_t sval;
> +
> +            sval = cvtnum(optarg);
> +            if (sval < 0) {
> +                if (sval == -ERANGE) {
> +                    error_report("Image size must be less than 8 EiB!");
> +                } else {
> +                    error_report("Invalid image size specified! You may use "
> +                                 "k, M, G, T, P or E suffixes for ");
> +                    error_report("kilobytes, megabytes, gigabytes, terabytes, "
> +                                 "petabytes and exabytes.");
> +                }
> +                goto out;
> +            }

I don't know if this is very important, but even under 8 EiB there are
image sizes that 'qemu-img measure' will treat as valid but are not
actually possible to create:

$ qemu-img measure -O qcow2 --size 7E
required size: 1231640938414080
fully allocated size: 8071682173186342912

$ build/qemu-img create -o cluster_size=2M -f qcow2 img.qcow2 7E
Formatting 'img.qcow2', fmt=qcow2 size=8070450532247928832 encryption=off cluster_size=2097152 lazy_refcounts=off refcount_bits=16
qemu-img: img.qcow2: The image size is too large for file format 'qcow2' (try using a larger cluster size)

Berto
