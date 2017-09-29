Received: from eggs.gnu.org ([2001:4830:134:3::10]:41850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gedwards@ddn.com>) id 1dy3Jl-0000NZ-1y
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gedwards@ddn.com>) id 1dy3Jg-0006c7-50
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:59:33 -0400
Received: from legacy.ddn.com ([64.47.133.206]:43532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gedwards@ddn.com>) id 1dy3Jf-0006bf-VM
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:59:28 -0400
Date: Fri, 29 Sep 2017 15:59:23 -0600
From: Greg Edwards <gedwards@ddn.com>
Message-ID: <20170929215922.GC4541@psuche>
References: <20170928205211.15641-1-gedwards@ddn.com>
	<2e1d2e56-7969-cb58-b462-dc140c3ff91c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2e1d2e56-7969-cb58-b462-dc140c3ff91c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] char: report errors from qio_channel_{read,
 write}v_full
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Fri, Sep 29, 2017 at 11:12:41AM +0200, Paolo Bonzini wrote:
> On 28/09/2017 22:52, Greg Edwards wrote:
>> Two callers of qio_channel_{read,write}v_full were not passing in an
>> Error pointer, missing any error messages from the channel class
>> io_{read,write}v methods.
>
> This is on purpose in order to avoid "spamming" the logs.  In
> particular, for sockets it can be a normal thing for the other side to
> disconnect.

Thanks for the background, Paolo.

We had encountered a vhost-user-scsi initialization failure, and were
looking for the errno from the recvmsg failure from
VHOST_USER_GET_FEATURES:

qemu-system-x86_64: -device vhost-user-scsi-pci,chardev=vus0,bootindex=2: Failed to read msg header. Read -1 instead of 12. Original request 1.
qemu-system-x86_64: -device vhost-user-scsi-pci,chardev=vus0,bootindex=2: vhost-user-scsi: vhost initialization failed: Operation not permitted

In this case, the strerror in vhost_user_scsi_realize is just reporting
on the -1 returned from the vhost_user_read failure, not the errno of
original offender.  That's what started me down this path.

Greg
