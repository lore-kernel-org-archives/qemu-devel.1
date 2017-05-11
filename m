Received: from eggs.gnu.org ([2001:4830:134:3::10]:33739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d8p5k-0007n4-83
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d8p5f-0002wE-9C
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:29:20 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170425153858.25660-12-berrange@redhat.com>
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-12-berrange@redhat.com>
Date: Thu, 11 May 2017 16:29:11 +0200
Message-ID: <w517f1ntqko.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 11/18] qcow2: convert QCow2 to use
 QCryptoBlock for encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Tue 25 Apr 2017 05:38:51 PM CEST, Daniel P. Berrange wrote:
> +    switch (s->crypt_method_header) {
> +    case QCOW_CRYPT_NONE:
> +        if (encryptfmt) {
> +            error_setg(errp, "No encryption in image header, but options "
> +                       "specified format '%s'", encryptfmt);
> +            goto fail;
> +        }
> +        break;

You forgot to set the return value here (it is undefined at this
point)...

> +
> +    case QCOW_CRYPT_AES:
> +        if (encryptfmt && !g_str_equal(encryptfmt, "aes")) {
> +            error_setg(errp,
> +                       "Header reported 'aes' encryption format but "
> +                       "options specify '%s'", encryptfmt);
> +            ret = -EINVAL;
> +            goto fail;
> +        }

...and here you could break instead, the condition immediately after the
switch sets ret to -EINVAL and returns.

> +##
> +# @BlockdevQcow2EncryptionFormat:
> +# @qcow: AES-CBC with plain64 initialization venctors
> +#
> +# Since: 2.10
> +##
> +{ 'enum': 'BlockdevQcow2EncryptionFormat',
> +  'data': [ 'qcow' ] }
> +

Same question here, isn't this supposed to be 'aes' ?

Berto
