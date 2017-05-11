Received: from eggs.gnu.org ([2001:4830:134:3::10]:43682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d8pKx-00049g-L7
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d8pKt-0005lW-Ph
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:45:03 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170425153858.25660-14-berrange@redhat.com>
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-14-berrange@redhat.com>
Date: Thu, 11 May 2017 16:44:56 +0200
Message-ID: <w514lwrtpuf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 13/18] qcow2: add support for LUKS
 encryption format
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

On Tue 25 Apr 2017 05:38:53 PM CEST, Daniel P. Berrange wrote:
> This adds support for using LUKS as an encryption format
> with the qcow2 file, using the new encrypt.format parameter
> to request "luks" format. e.g.
>
>   # qemu-img create --object secret,data=123456,id=sec0 \
>        -f qcow2 -o encrypt.-format=luks,encrypt.key-secret=sec0 \
>        test.qcow2 10G
>
> The legacy "encryption=on" parameter still results in
> creation of the old qcow2 AES format (and is equivalent
> to the new 'encryption-format=aes'). e.g. the following are
> equivalent:
>
>   # qemu-img create --object secret,data=123456,id=sec0 \
>        -f qcow2 -o encryption=on,encrypt.key-secret=sec0 \
>        test.qcow2 10G
>
>  # qemu-img create --object secret,data=123456,id=sec0 \
>        -f qcow2 -o encryption-format=aes,encrypt.key-secret=sec0 \
>        test.qcow2 10G
>
> With the LUKS format it is necessary to store the LUKS
> partition header and key material in the QCow2 file. This
> data can be many MB in size, so cannot go into the QCow2
> header region directly. Thus the spec defines a FDE
> (Full Disk Encryption) header extension that specifies
> the offset of a set of clusters to hold the FDE headers,
> as well as the length of that region. The LUKS header is
> thus stored in these extra allocated clusters before the
> main image payload.
>
> Aside from all the cryptographic differences implied by
> use of the LUKS format, there is one further key difference
> between the use of legacy AES and LUKS encryption in qcow2.
> For LUKS, the initialiazation vectors are generated using
> the host physical sector as the input, rather than the
> guest virtual sector. This guarantees unique initialization
> vectors for all sectors when qcow2 internal snapshots are
> used, thus giving stronger protection against watermarking
> attacks.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
