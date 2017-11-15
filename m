Received: from eggs.gnu.org ([2001:4830:134:3::10]:52777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEy0U-0000wC-4x
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEy0P-0004JV-93
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:45:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40023)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eEy0O-0004IU-TH
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:45:29 -0500
References: <20171115124602.12501-1-ppandit@redhat.com>
	<20171115125151.GG20349@redhat.com>
	<f569ccce-4aa5-423a-25b2-baf69e8e6b43@redhat.com>
	<20171115133034.GB4418@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b18ca48a-8785-9642-584e-c82f0cf7eaba@redhat.com>
Date: Wed, 15 Nov 2017 14:45:20 +0100
MIME-Version: 1.0
In-Reply-To: <20171115133034.GB4418@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ps2: fix PS2Queue counter field type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, P J P <ppandit@redhat.com>, Cyrille Chatras <cyrille.chatras@orange.com>, Gerd Hoffmann <kraxel@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>

On 15/11/2017 14:30, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>> On 15/11/2017 13:51, Daniel P. Berrange wrote:
>>> If you're concerned that someone is tampering with QEMU state
>>> in transit during migration, then you're going to end up playing
>>> whack-a-mole across the entire QEMU codebase IMHO. The answer
>>> to the problem of tampering is to have encryption of the
>>> migration data stream between both QEMU's. Thus QEMU on the
>>> target merely has to trust QEMU on the source. If QEMU on the
>>> source is itself compromised you've already lost and migration
>>> won't make life any worse.
>>
>> This is not entirely true.  A lot of such cases were fixed in the past=
,
>> especially when they could cause out-of-bounds access.  Someone could
>> provide a bad migration stream (e.g. as a fake bug report!), so
>> migration data should not be considered trusted.
>=20
> There's probably others to be honest; it's not something we've
> traditionally been careful of.

There was a flurry of fixes a while ago:

- CVE-2013-4149 to CVE-2013-4151
- CVE-2013-4526 to CVE-2013-4527
- CVE-2013-4529 to CVE-2013-4542
- CVE-2013-6399
- CVE-2014-0182

This one was introduced in 2.1, around the same time these others were
fixed, by commit 2858ab09e6 ("ps2: set ps/2 output buffer size as the
same as kernel", 2014-05-16).

Thanks,

Paolo

>=20
>> However, PJP's patch breaks migration by changing a 4-byte field to
>> 1-byte.  The correct fix is to range-check the fields in
>> ps2_common_post_load.
>=20
> Agreed.
>=20
> Dave
>=20
>> Thanks,
>>
>> Paolo
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
