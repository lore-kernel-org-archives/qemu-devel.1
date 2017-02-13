Received: from eggs.gnu.org ([2001:4830:134:3::10]:41505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cdI0c-00064T-IV
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:53:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cdI0Z-00046n-Bz
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:53:42 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170210170910.8867-10-berrange@redhat.com>
References: <20170210170910.8867-1-berrange@redhat.com>
	<20170210170910.8867-10-berrange@redhat.com>
Date: Mon, 13 Feb 2017 15:53:36 +0100
Message-ID: <w51fujiywen.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 09/18] qcow: convert QCow to use
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri 10 Feb 2017 06:09:01 PM CET, Daniel P. Berrange wrote:
> This converts the qcow2 driver to make use of the QCryptoBlock

s/qcow2/qcow/

> APIs for encrypting image content. This is only wired up to
> permit use of the legacy QCow encryption format. Users who wish
> to have the strong LUKS format should switch to qcow2 instead.

> @@ -104,7 +114,18 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>      unsigned int len, i, shift;
>      int ret;
>      QCowHeader header;
> +    QemuOpts *opts = NULL;
>      Error *local_err = NULL;
> +    QCryptoBlockOpenOptions *crypto_opts = NULL;
> +    unsigned int cflags = 0;
> +
> +    opts = qemu_opts_create(&qcow_runtime_opts, NULL, 0, &error_abort);

I think you're leaking opts here.

Berto
