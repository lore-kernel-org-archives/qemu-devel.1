Received: from eggs.gnu.org ([209.51.188.92]:47998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1grMhU-0003bp-27
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 07:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1grMhR-00022n-Ou
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 07:53:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1grMhQ-0001zP-8t
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 07:53:08 -0500
References: <20190206124345.14942-1-berto@igalia.com>
	<20190206124902.GI12331@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7e15d04-c8d5-4415-fdea-c71015607965@redhat.com>
Date: Wed, 6 Feb 2019 13:52:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190206124902.GI12331@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] char-socket: hold chr_write_lock
 during tcp_chr_free_connection()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 06/02/19 13:49, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Feb 06, 2019 at 02:43:45PM +0200, Alberto Garcia wrote:
>> There's a race condition in which the tcp_chr_read() ioc handler can
>> close a connection that is being written to from another thread.
> Isn't the chardev only ever supposed to be read/written from a
> single thread.
>=20

No, writes from multiple threads are allowed; of course they have to
have proper locking to avoid mixing messages.

Reads have to happen from a single thread because they are tied to the
chr_read handlers.

Paolo
