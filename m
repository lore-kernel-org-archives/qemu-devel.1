Received: from eggs.gnu.org ([2001:4830:134:3::10]:46154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f8lNG-0002Jx-Dy
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f8lNF-0005KQ-4W
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:35:42 -0400
MIME-Version: 1.0
In-Reply-To: <860de622-d4cc-d1bf-ae27-e4d70d5d22f0@redhat.com>
References: <20180416181844.7851-1-marcandre.lureau@redhat.com>
	<CAFEAcA8sX8e9VHdOjhV9VabuVKW=HKiF-bHz3XhCEkRNEyjnDQ@mail.gmail.com>
	<20180416184406.GC14488@redhat.com>
	<CAFEAcA_uS7f-uf+-OkcskdHG3=eTgr92Mw46nk430q27-wve4g@mail.gmail.com>
	<19b7bccd-2282-5c94-fe7c-68f72ccbaba7@amsat.org>
	<CAJ+F1CJ4HurD8=OC+qhHSEuNDkO7_QQaiJtH_RVHSu4-xzrqag@mail.gmail.com>
	<860de622-d4cc-d1bf-ae27-e4d70d5d22f0@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 18 Apr 2018 13:35:35 +0200
Message-ID: <CAJ+F1C+eHYnjZkqh=cFSm7Dw8Udbf-g+-Ck2sgVkqxFQhLxXjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] mux: fix ctrl-a b again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi

On Wed, Apr 18, 2018 at 12:55 PM, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> On 18/04/2018 12:36, Marc-Andr=C3=A9 Lureau wrote:
>>
>> +            if (chr =3D=3D NULL || chr->be) {
>> +                name =3D g_strdup_printf("discarding-serial%d", i);
>> +                chr =3D qemu_chr_new(name, "null");
>> +            } else {
>> +                name =3D g_strdup_printf("serial%d", i);
>> +            }
>>
>> Why do you check if chr->be ? In case of a mux chardev, it may already
>> have an active frontend (yeah be is CharBackend which is the frontend,
>> I still can't grasp that either, please Paolo change your mind! ;).
>
> CharBackend is not the frontend, it is *used* by the front-end.  It is
> the qemu_chr_* functions that are named wrong (they're named according
> to the user rather than the recipient).

If I follow you and the naming, you have this in mind:

- Chardev: stdio, mux, ringbuf, pty, file, null etc..
- CharBackend: the "user" end
- frontend: the "user"

It is quite confusing to me that CharBackend is for the "user"
frontend, and the backend of Chardev. You have to switch your mind
depending on the context or the point of view.

 I'd rather use that terminology:

- ChardevBackend: stdio, mux, ringbuf, pty, file, null etc..
- CharFrontend: the "user" end
- frontend the "user"

This way, there is only one direction from backend to frontend
(regardless of the point of view from chardev to frontend)

And rename struct and functions accordingly.

Do you have another proposal to simplify the current situation?

--=20
Marc-Andr=C3=A9 Lureau
