Received: from eggs.gnu.org ([2001:4830:134:3::10]:58588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <florolf@n621.de>) id 1eyK0k-00043I-Rq
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <florolf@n621.de>) id 1eyK0k-0003I0-1h
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:21:18 -0400
Received: from nyx.n621.de ([2a01:4f8:151:8ffd:2::1]:60413)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <florolf@n621.de>) id 1eyK0j-0003HF-RC
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:21:17 -0400
Date: Tue, 20 Mar 2018 17:21:16 +0100
From: Florian Larysch <fl@n621.de>
Message-ID: <20180320162116.GD15157@nyx.n621.de>
References: <20180320093135.26422-1-fl@n621.de>
	<d5ad61b8-1570-0234-fd2a-97dfb174de59@redhat.com>
	<20180320160243.GZ4530@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180320160243.GZ4530@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] os: truncate pidfile on creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, sw@weilnetz.de

On Tue, Mar 20, 2018 at 04:02:44PM +0000, Daniel P. Berrang=E9 wrote:
> No, it is unsafe - we rely on lockf() to get the mutual exclusion.
> If a QEMU is running with pidfile locked, and its pid written into
> it, then a 2nd QEMU comes along it will truncate the pidfile owned
> by the original QEMU because the truncation happens before it has
> tried to acquire the lock. The 2nd QEMU will still exit, but the
> original QEMU's pid has now been lost.

That's correct, thanks for pointing it out.

> We must call ftruncate() after lockf(), but before writing the new
> pid into the file. That ensures there is no window in which it is
> possible to see the new & old pids mixed together.

I'll send a revised version doing exactly that.

>From my reading of the Windows API documentation, this might not be a
problem there: The file is opened with FILE_SHARE_READ, which prohibits
opening the file in a writable mode and CREATE_ALWAYS will only recreate
the file if it is writable.

Florian
