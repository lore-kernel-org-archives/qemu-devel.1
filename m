Received: from eggs.gnu.org ([2001:4830:134:3::10]:55703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUpjB-0002aW-IC
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:13:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUpj6-0006SC-Hk
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:13:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUpj6-0006Ru-57
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:13:44 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181205203737.9011-1-marcandre.lureau@redhat.com>
	<20181205203737.9011-5-marcandre.lureau@redhat.com>
	<87bm5zkx0o.fsf@dusky.pond.sub.org>
	<CAMxuvazPAjrEt2nyEVSwsVhap-dEGGXSa-N1GcdgK-UuhMfN+Q@mail.gmail.com>
Date: Thu, 06 Dec 2018 10:13:35 +0100
In-Reply-To: <CAMxuvazPAjrEt2nyEVSwsVhap-dEGGXSa-N1GcdgK-UuhMfN+Q@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 6 Dec 2018
	10:23:45 +0400")
Message-ID: <87tvjrhvb4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 4/7] monitor: check if chardev
 can switch gcontext for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: lizhijian@cn.fujitsu.com, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, zhangckid@gmail.com, "Bonzini, Paolo" <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
> On Thu, Dec 6, 2018 at 10:08 AM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> One more question...
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Not all backends are able to switch gcontext. Those backends cannot
>> > drive a OOB monitor (the monitor would then be blocking on main
>> > thread).
>> >
>> > For example, ringbuf, spice, or more esoteric input chardevs like
>> > braille or MUX.
>>
>> These chardevs don't provide QEMU_CHAR_FEATURE_GCONTEXT.
>>
>> > We currently forbid MUX because not all frontends are ready to run
>> > outside main loop. Extend to add a context-switching feature check.
>>
>> Why check CHARDEV_IS_MUX() when chardev-mux already fails the
>> qemu_char_feature_gcontext(chr, QEMU_CHAR_FEATURE_GCONTEXT) check?
>>
>
>
> It currently fails, but with "[PATCH 4/9] char: update the mux
> hanlders in class callback", it won't.

That's because it makes chardev-mux implement chr_update_read_handler(),
and "[PATCH 3/7] char: add a QEMU_CHAR_FEATURE_GCONTEXT flag" assumes
that a chardev implementing that "will take the updated gcontext into
account".

Sounds to me as if "[PATCH 4/9] char: update the mux hanlders in class
callback" violates that assumption.  Why am I wrong?

> But the main reason to keep an explicit check on mux is that the
> monitor frontend doesn't know if other mux frontends can be called
> from any context (when you set a context, it is set on the backend
> side, events are dispatched by the backend).
>
> We may want to mix this extra frontend-side capability limitation with
> FEATURE_GCONTEXT flag, but they are fundamentally different: to be
> able to set a backend context VS attached mux frontends can be
> dispatched from any context.

I'm afraid I can't yet see the full picture.

The goal of this series PATCH 3-5 is to catch certain thread-related
badness in chardevs before it can happen.

Apparently, there are two separate kinds of badness:

* The chardev backend may fail to cope with changed gcontext.  I don't
  understand how exactly the backends screw up, but I doubt I have to
  right now.

* The chardev frontend may fail to... what exactly?  And why is only
  chardev-mux affected?

[...]
