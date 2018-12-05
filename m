Received: from eggs.gnu.org ([2001:4830:134:3::10]:40341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUTHL-0003KC-0g
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUTHF-00014p-OD
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:15:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUTHD-00012t-LT
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:15:28 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181204131802.16885-1-marcandre.lureau@redhat.com>
	<20181204131802.16885-5-marcandre.lureau@redhat.com>
	<874lbs1i0g.fsf@dusky.pond.sub.org>
	<CAJ+F1CLBueWzyFJtm+GxfO1rc-KcEpcz_qwo=O3mmW68zyN0eA@mail.gmail.com>
Date: Wed, 05 Dec 2018 10:15:21 +0100
In-Reply-To: <CAJ+F1CLBueWzyFJtm+GxfO1rc-KcEpcz_qwo=O3mmW68zyN0eA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 5 Dec 2018
	12:54:45 +0400")
Message-ID: <87a7lkwd06.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/6] monitor: check if chardev can
 switch gcontext for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Wed, Dec 5, 2018 at 12:43 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Not all backends are able to switch gcontext. Those backends cannot
>> > drive a OOB monitor (the monitor would then be blocking on main
>> > thread).
>> >
>> > For example, ringbuf, spice, or more esoteric input chardevs like
>> > braille or MUX.
>> >
>> > We currently forbid MUX because not all frontends are ready to run
>> > outside main loop. Extend to add a context-switching feature check.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  monitor.c | 6 ++++--
>> >  1 file changed, 4 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/monitor.c b/monitor.c
>> > index 79afe99079..25cf4223e8 100644
>> > --- a/monitor.c
>> > +++ b/monitor.c
>> > @@ -4562,9 +4562,11 @@ void monitor_init(Chardev *chr, int flags)
>> >      bool use_oob =3D flags & MONITOR_USE_OOB;
>> >
>> >      if (use_oob) {
>> > -        if (CHARDEV_IS_MUX(chr)) {
>> > +        if (CHARDEV_IS_MUX(chr) ||
>> > +            !qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
>> >              error_report("Monitor out-of-band is not supported with "
>> > -                         "MUX typed chardev backend");
>> > +                         "%s typed chardev backend",
>> > +                         object_get_typename(OBJECT(chr)));
>> >              exit(1);
>> >          }
>> >          if (use_readline) {
>>
>> Aha, this answers my question on the previous patch: yes, it is possible
>> to trip the new assertion.
>>
>> Are there any ways other than this one?
>
> Good question, if there are, we have latent bugs if switching gcontext
> on a non-capable chardev.
>
> Doing a quick review of qemu_chr_fe_set_handlers() for context !=3D NULL
> reveals net/colo-compare.c:
>
> I think we should have the capability check added to find_and_check_chard=
ev().
>
> I don't see other candidates. Considering the problem is pre-existing,
> I can either update the patch or add a follow-up patch.

If the pre-existing bug is just as bad as an assertion failure, then I'm
fine with turning it into an assertion failure, with a brief explanation
in the commit message.

>> We could squash the two patches.  But I figure you kept the previous
>> patch separate on purpose.  That's okay, but it should mention the
>> assertion can be tripped, and the next patch (this one) will fix it.
