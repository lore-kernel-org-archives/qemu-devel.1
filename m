Received: from eggs.gnu.org ([2001:4830:134:3::10]:59995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCkOb-0006gH-Do
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCkOa-0006BX-Jd
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:53:49 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:42184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gCkOa-0006Aa-CD
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:53:48 -0400
Received: by mail-ot1-x32f.google.com with SMTP id c23so24062601otl.9
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 04:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539259394.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539259394.git.artem.k.pisarenko@gmail.com>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Wed, 17 Oct 2018 17:53:35 +0600
Message-ID: <CANzW0msA_rZrqucrgMxTFtwiZgJA_+w0O4zA2P64_L_XKs96hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Fix and improve core RTC function and
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I checked it with ./configure --enable-debug and didn't imagined that in
non-debug build (with -O2) compiler will complain:
   "vl.c:847:12: error: =E2=80=98seconds=E2=80=99 may be used uninitialized=
 in this
function [-Werror=3Dmaybe-uninitialized]"

    int qemu_timedate_diff(struct tm *tm)
    {
        time_t seconds;
        switch (rtc_base_type) {
        case RTC_BASE_DATETIME:
        case RTC_BASE_UTC:
            seconds =3D mktimegm(tm);
            break;
        case RTC_BASE_LOCALTIME:
        {
            struct tm tmp =3D *tm;
            tmp.tm_isdst =3D -1; /* use timezone to figure it out */
            seconds =3D mktime(&tmp);
            break;
        }
        }
>>>  return seconds - qemu_ref_timedate(QEMU_CLOCK_HOST);
    }

Switch covers all defined enum values, so 'second' cannot be left
uninitialized. One way it could be is if someone assigns integer value to
'rtc_base_type' variable explicitly. Ok, let's look at it. This variable
initialized with valid value at definition and elsewhere in code it's being
assigned only valid enum values. Maybe it could be changed outside of
compile unit ? No, it's defined as static. Maybe GCC isn't just smart
enough to check it in whole compile unit scope context ? From my expirience
I've seen that it's able to make even more complex assumptions and smart
decisions. And with higher optimization levels GCC becomes just smarter.
But this time GCC behavior differs...
--=20

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE
