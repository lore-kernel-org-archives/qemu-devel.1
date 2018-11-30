Received: from eggs.gnu.org ([2001:4830:134:3::10]:52973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSftm-0003pW-IR
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSftl-00048c-HR
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:19:50 -0500
Date: Fri, 30 Nov 2018 10:19:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181130101936.GG8101@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1bc34791-6ae3-cbcd-222f-468b89205f64@virtuozzo.com>
	<50b00028-9f75-743b-cdec-58cd367a268a@virtuozzo.com>
	<20181127160841.GJ18381@redhat.com>
	<22fee90b-8144-212e-ad19-94480491f05b@virtuozzo.com>
	<20181130094847.GB8101@redhat.com>
	<9e19d16b-b1a3-30cf-3687-620e22ce1fb9@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e19d16b-b1a3-30cf-3687-620e22ce1fb9@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] encrypt in threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri, Nov 30, 2018 at 10:04:57AM +0000, Vladimir Sementsov-Ogievskiy wr=
ote:
> 30.11.2018 12:48, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Nov 29, 2018 at 06:28:44PM +0000, Vladimir Sementsov-Ogievski=
y wrote:
> >>
> >> On 27.11.2018 16:08, Daniel P. Berrang=C3=A9 wrote:
> >>> On Thu, Nov 22, 2018 at 01:01:20PM +0000, Vladimir Sementsov-Ogievs=
kiy wrote:
> >>>> 21.11.2018 20:30, Vladimir Sementsov-Ogievskiy wrote:
> >>>>> Hi Daniel!
> >>>>>
> >>>>> After moving compression to threads in Qcow2 it's an obvious next=
 step to
> >>>>> "threadyfy" encryption in Qcow2 too.
> >>>>>
> >>>>> But it turned out to be not as simple as I assumed. If I call qcr=
ypto_block_encrypt
> >>>>> in parallel threads with the same first argument (block), it just=
 produce wrong
> >>>>> things (pattern verification fails in iotests)..
> >>>>>
> >>>>> So, can you advise the way to parallelize encryption/decryption?
> >>>>>
> >>>> Hmm, just creating QCryptoBlock per each thread helped. Is it corr=
ect thing to do?
> >>> That's rather a heavy weight approach and would cause pain when we =
want
> >>> to support future options such as keyslot updates, and in the futur=
e,
> >>> LUKSv2 with master key changes.
> >>>
> >>> Probably what's needed is change to QCryptoBlock struct so that the=
re
> >>> can be multiple QCryptoCipher instances allocated - one per thread.
> >>>
> >>> We might also need to introduce some locking around usage of the
> >>> QCryptoIVGen object, since that has a QCryptoCipher handle too.
> >>
> >>
> >> Can we also create QCryptoIVGen per thread, as QCryptoCipher? Or it
> >> should be one? If one, why my implementation with QCryptoBlock per
> >> thread works (at least it passes iotests, hmm)
> >=20
> > The only IV generator that uses ciphers is the "essiv" one. Even that
> > one uses the cipher in ECB mode, so there is no initialization vector
> > required for its internal cipher. This means there's no critical
> > shared state that would be overwritten by threads. Thus using a
> > separate QCryptoCipher per thread for the essiv IV gen is overkill.
> > None the less I think we should protect the IV generator calls with
> > a mutex just to be safe. I don't think the mutex would have a notable
> > impact on performance of the iv generator.
>=20
> But if we use mutex, it means that we can't generate two ivs in paralle=
l,
> and then, it becomes better to have separate iv-gen per thread, instead
> of only one, protected by mutex. (or I don't follow)

I'm questioning whether parallelism of the iv-gen is actually needed
though. It has very short execution time, only encrypting 64 bits of
data, per 512 byte sector with essiv.

If you have show performance numbers that prove a per-thread iv generator
is needed for ESSIV I'd accept that, otherwise I'd just go for a mutex.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
