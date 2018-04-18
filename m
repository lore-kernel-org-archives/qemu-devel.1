Received: from eggs.gnu.org ([2001:4830:134:3::10]:54005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f8nQu-0003Hi-IA
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f8nQq-0007nq-H0
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:47:36 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
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
From: Paolo Bonzini <bonzini@gnu.org>
Message-ID: <28f65c23-65b9-fe96-7285-450f61819114@gnu.org>
Date: Wed, 18 Apr 2018 15:47:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJFfTBJkEEDP4R4PKU1grVU9Bhxjt9WjdKKX84KFizoCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] mux: fix ctrl-a b again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 18/04/2018 14:22, Marc-André Lureau wrote:
>>> - Chardev: stdio, mux, ringbuf, pty, file, null etc..
>>> - CharBackend: the "user" end
>>> - frontend: the "user"
>> The frontend is the device, the monitor, etc.
> yes, I should have listed it for clarity
> 
>> The backend is how the
>> frontend sees a Chardev, it never talks to it directly.
> 
> Ok, but why not call CharFrontend, since it's the frontend interface
> to the chardev? (which we call the backend, by extension, and because
> many functions are named *_be_* )

The frontend interface is not the same thing as the frontend, though.
The frontend interface is the backend.

> It's less confusing, because that part is mostly internal to char.c
> implementation.
> 
> But rather than:
> 
> static void chr_be_event(Chardev *s, int event)
> {
>     CharBackend *be = s->be;
> ...
>     be->chr_event(be->opaque, event);
> }
> 
> I would rather have:
> 
> static void chr_be_event(Chardev *s, int event)
> {
>     CharFrontend *fe = s->fe;
> ...
>     fe->chr_event(fe->opaque, event);
> }

What I would rather have instead is this:

   static void qemu_chr_be_send_event(CharBackend *be, int event)
   {
       if (be->frontend_ops && be->frontend_ops->chr_event) {
           /* Or: be->frontend->chr_event(be->frontend, event);
           be->frontend_ops->chr_event(be->frontend_ops->opaque, event);
       }
   }

   static void chr_send_event(Chardev *s, int event)
   {
       qemu_chr_be_send_event(s->be, event);
   }

(and likewise qemu_chr_be_can_write asks be->frontend_ops->chr_can_read,
qemu_chr_be_write_impl invokes be->frontend_ops->chr_read).  Then the
tx<->rx switch is clear from accessing frontend_ops.

> This would not only mean that we clearly associate CharBackend with
> the frontend, but also the chardev code becomes clearer, sending an
> event on the chardev (be), forwards it to the frontend side... (that
> is so much clearer to me)

The problem I have with calling it CharFrontend, is that for example
"int tag" has nothing to do with the front end.

Paolo
