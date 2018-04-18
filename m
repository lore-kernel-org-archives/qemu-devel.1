Received: from eggs.gnu.org ([2001:4830:134:3::10]:33373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f8neX-0001ns-4T
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f8neR-0006ZQ-Ao
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:01:41 -0400
MIME-Version: 1.0
In-Reply-To: <28f65c23-65b9-fe96-7285-450f61819114@gnu.org>
References: <20180416181844.7851-1-marcandre.lureau@redhat.com>
	<CAFEAcA8sX8e9VHdOjhV9VabuVKW=HKiF-bHz3XhCEkRNEyjnDQ@mail.gmail.com>
	<20180416184406.GC14488@redhat.com>
	<CAFEAcA_uS7f-uf+-OkcskdHG3=eTgr92Mw46nk430q27-wve4g@mail.gmail.com>
	<19b7bccd-2282-5c94-fe7c-68f72ccbaba7@amsat.org>
	<CAJ+F1CJ4HurD8=OC+qhHSEuNDkO7_QQaiJtH_RVHSu4-xzrqag@mail.gmail.com>
	<860de622-d4cc-d1bf-ae27-e4d70d5d22f0@redhat.com>
	<CAJ+F1C+eHYnjZkqh=cFSm7Dw8Udbf-g+-Ck2sgVkqxFQhLxXjA@mail.gmail.com>
	<4a75a9c0-8cf5-5ec1-8edc-e768f360e96f@redhat.com>
	<CAJ+F1CJFfTBJkEEDP4R4PKU1grVU9Bhxjt9WjdKKX84KFizoCg@mail.gmail.com>
	<28f65c23-65b9-fe96-7285-450f61819114@gnu.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 18 Apr 2018 16:01:18 +0200
Message-ID: <CAJ+F1C+-0L8NDUnhNn=GR9DTHrWQr2Jxp3UMbE9R796fsibVBQ@mail.gmail.com>
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
To: Paolo Bonzini <bonzini@gnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi

On Wed, Apr 18, 2018 at 3:47 PM, Paolo Bonzini <bonzini@gnu.org> wrote:
> On 18/04/2018 14:22, Marc-Andr=C3=A9 Lureau wrote:
>>>> - Chardev: stdio, mux, ringbuf, pty, file, null etc..
>>>> - CharBackend: the "user" end
>>>> - frontend: the "user"
>>> The frontend is the device, the monitor, etc.
>> yes, I should have listed it for clarity
>>
>>> The backend is how the
>>> frontend sees a Chardev, it never talks to it directly.
>>
>> Ok, but why not call CharFrontend, since it's the frontend interface
>> to the chardev? (which we call the backend, by extension, and because
>> many functions are named *_be_* )
>
> The frontend interface is not the same thing as the frontend, though.
> The frontend interface is the backend.
>
>> It's less confusing, because that part is mostly internal to char.c
>> implementation.
>>
>> But rather than:
>>
>> static void chr_be_event(Chardev *s, int event)
>> {
>>     CharBackend *be =3D s->be;
>> ...
>>     be->chr_event(be->opaque, event);
>> }
>>
>> I would rather have:
>>
>> static void chr_be_event(Chardev *s, int event)
>> {
>>     CharFrontend *fe =3D s->fe;
>> ...
>>     fe->chr_event(fe->opaque, event);
>> }
>
> What I would rather have instead is this:
>
>    static void qemu_chr_be_send_event(CharBackend *be, int event)
>    {
>        if (be->frontend_ops && be->frontend_ops->chr_event) {
>            /* Or: be->frontend->chr_event(be->frontend, event);
>            be->frontend_ops->chr_event(be->frontend_ops->opaque, event);
>        }
>    }
>
>    static void chr_send_event(Chardev *s, int event)
>    {
>        qemu_chr_be_send_event(s->be, event);
>    }

Yeah I think I got your point. That looks more complicated than my
proposal though. This chardev->be->frontend dance is unnecessarily
complex for me. I would go from be->fe directly.
>
> (and likewise qemu_chr_be_can_write asks be->frontend_ops->chr_can_read,
> qemu_chr_be_write_impl invokes be->frontend_ops->chr_read).  Then the
> tx<->rx switch is clear from accessing frontend_ops.
>
>> This would not only mean that we clearly associate CharBackend with
>> the frontend, but also the chardev code becomes clearer, sending an
>> event on the chardev (be), forwards it to the frontend side... (that
>> is so much clearer to me)
>
> The problem I have with calling it CharFrontend, is that for example
> "int tag" has nothing to do with the front end.
>

well, if it's just that, we may find a way to move it somewhere else,
or simply add some comment that those fields are not to be manipulated
by the frontend directly (well, all fields I suppose, in theory).

> Paolo



--=20
Marc-Andr=C3=A9 Lureau
