Received: from eggs.gnu.org ([2001:4830:134:3::10]:43932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fb2VF-0000fg-LX
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fb2VE-0002tC-N2
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:32:49 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fb2VE-0002ql-Ge
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:32:48 -0400
Received: by mail-wm0-x243.google.com with SMTP id p11-v6so10231972wmc.4
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 04:32:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87sh4y7xcw.fsf@dusky.pond.sub.org>
References: <20180704084507.14560-1-peterx@redhat.com>
	<20180704084507.14560-5-peterx@redhat.com>
	<87woua9iay.fsf@dusky.pond.sub.org> <20180705094903.GA23001@xz-mi>
	<87sh4y7xcw.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 5 Jul 2018 13:32:46 +0200
Message-ID: <CAJ+F1CL1r034g1eGNtiZE1birByMNvyJLwym8e3Jn058cbbnOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/9] monitor: move need_resume flag into
 monitor struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Thu, Jul 5, 2018 at 1:09 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Peter Xu <peterx@redhat.com> writes:
>
>> On Thu, Jul 05, 2018 at 10:51:33AM +0200, Markus Armbruster wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>>
>>> > It was put into the request object to show whether we'll need to resu=
me
>>> > the monitor after dispatching the command.  Now we move that into the
>>> > monitor struct so that it might be even used in other places in the
>>> > future, e.g., out-of-band message flow controls.
>>> >
>>> > One thing to mention is that there is no lock needed before when
>>> > accessing the flag since the request object will always be owned by a
>>> > single thread.  After we move it into monitor struct we need to prote=
ct
>>> > that flag since it might be accessed by multiple threads now.  Renami=
ng
>>> > the qmp_queue_lock into qmp_lock to protect the flag as well.
>>> >
>>> > No functional change.
>>> >
>>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>>>
>>> Marc-Andr=C3=A9's "[PATCH v3 04/38] monitor: no need to save need_resum=
e" and
>>> "[PATCH v3 05/38] monitor: further simplify previous patch" also mess
>>> with need_resume.  Marc-Andr=C3=A9, could you have a look at this patch=
 and
>>> the next one?
>>
>> Sorry I should have looked at those before hand.  I think I must be
>> waiting for another post to split the patches into two (after
>> Marc-Andre poked me with that thread) but then I forgot about that.
>>
>> So now I suspect we'd better keep that flag since in the next patch
>> the suspend operation can happen conditionally now.
>
> Could you two together figure out how to combine your work?  Would take
> me off this critical path...
>

With Peter patches, the monitor is also suspended when the queue of
command is too long (when oob-enabled). Thus the variable now covers
one of two different cases.

My patches only covered the first case simplification (legacy /
!oob-enabled suspend).

The second case could probably use a similar simplification, looking
at the queue length, but at this point I think I'd prefer to keep the
variable for clarity and sanity state checking.


--=20
Marc-Andr=C3=A9 Lureau
