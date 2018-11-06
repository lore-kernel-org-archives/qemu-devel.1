Received: from eggs.gnu.org ([2001:4830:134:3::10]:49383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK0kl-0004nZ-0B
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK0il-0006oV-U9
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:44:40 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gK0ic-0006Zi-Eb
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:44:33 -0500
Received: by mail-ot1-x343.google.com with SMTP id z33so11130373otz.11
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 04:44:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <BN6PR18MB122013B6029A135A5B6ADD079FCB0@BN6PR18MB1220.namprd18.prod.outlook.com>
References: <20181106115351.9422-1-ppandit@redhat.com>
	<CAFEAcA880MNu+_C1ySic7ASsQNMth1FCGSjHJg_N7Ud+s4G_PA@mail.gmail.com>
	<BN6PR18MB122007CFC965C45DF2CA20BB9FCB0@BN6PR18MB1220.namprd18.prod.outlook.com>
	<5127334b-e3c3-cf08-6855-8b6fd871cb5f@redhat.com>
	<BN6PR18MB122013B6029A135A5B6ADD079FCB0@BN6PR18MB1220.namprd18.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 12:44:06 +0000
Message-ID: <CAFEAcA9UzzkD7KqA6=ui3rh=296G==9tpCmcE8jV790SdCXHbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] lsi53c895a: check script ram address value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: li qiang <liq3ea@outlook.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>

On 6 November 2018 at 12:38, li qiang <liq3ea@outlook.com> wrote:
>
> =E5=9C=A8 2018/11/6 20:28, Paolo Bonzini =E5=86=99=E9=81=93:
>> On 06/11/2018 13:27, li qiang wrote:
>>> The addr is 0~0x1fff, but when addr is at the near the end ,for example
>>> 0x1fffe, the add>>2 can be 2047
>>>
>>> and as script_ram is a uint32_t and so s->script_ram[addr >> 2] can rea=
d
>>> out of the script_ram.
>> How so?  s->script_ram has size 2048, it's okay to access it at 2047.
>
> Oh, right.
>
>   I'm confused by the script_ram, it's not byte array.

Incidentally, I think the read and write functions here
would be somewhat clearer written as

static void lsi_ram_write(void *opaque, hwaddr addr,
                          uint64_t val, unsigned size)
{
    LSIState *s =3D opaque;
    void *p =3D ((void *)s->script_ram) + addr;

    assert(addr + size <=3D sizeof(s->script_ram));
    stn_p(p, size, val);
}

static uint64_t lsi_ram_read(void *opaque, hwaddr addr,
                             unsigned size)
{
    LSIState *s =3D opaque;
    void *p =3D ((void *)s->script_ram) + addr;

    assert(addr + size <=3D sizeof(s->script_ram));
    return ldn_p(p, size);
}

thanks
-- PMM
