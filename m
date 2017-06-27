Received: from eggs.gnu.org ([2001:4830:134:3::10]:53703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPmZJ-0003Xc-E3
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPmZE-0000H4-EV
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:13:57 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:52945)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dPmZE-0000GM-2a
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:13:52 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924253.28532.2681638904562623104.stgit@frigg.lan>
	<ca41d7c2-b009-46b9-1f76-3e45c0f91ecf@twiddle.net>
	<877ezzapyu.fsf@frigg.lan>
	<11b802c6-253c-1aaf-75d1-1f73e23c4d64@twiddle.net>
Date: Tue, 27 Jun 2017 12:13:42 +0300
In-Reply-To: <11b802c6-253c-1aaf-75d1-1f73e23c4d64@twiddle.net> (Richard
	Henderson's message of "Mon, 26 Jun 2017 18:10:14 -0700")
Message-ID: <87a84tlrnd.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 2/6] queue: Add macro for incremental
 traversal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Richard Henderson writes:

> On 06/26/2017 05:33 AM, Llu=C3=ADs Vilanova wrote:
>> Richard Henderson writes:
>>=20
>>> On 06/12/2017 07:54 AM, Llu=C3=ADs Vilanova wrote:
>>>> Adds macro QTAILQ_FOREACH_CONTINUE to support incremental list
>>>> traversal.
>>>>=20
>>>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>>>> ---
>>>> include/qemu/queue.h |   12 ++++++++++++
>>>> 1 file changed, 12 insertions(+)
>>>>=20
>>>> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
>>>> index 35292c3155..eb2bf9cb1c 100644
>>>> --- a/include/qemu/queue.h
>>>> +++ b/include/qemu/queue.h
>>>> @@ -415,6 +415,18 @@ struct {                                         =
                       \
>>>> (var);                                                  \
>>>> (var) =3D ((var)->field.tqe_next))
>>>> +/**
>>>> + * QTAILQ_FOREACH_CONTINUE:
>>>> + * @var: Variable to resume iteration from.
>>>> + * @field: Field in @var holding a QTAILQ_ENTRY for this queue.
>>>> + *
>>>> + * Resumes iteration on a queue from the element in @var.
>>>> + */
>>>> +#define QTAILQ_FOREACH_CONTINUE(var, field)                          =
   \
>>>> +        for ((var) =3D ((var)->field.tqe_next);                      =
     \
>>>> +                (var);                                               =
   \
>>>> +                (var) =3D ((var)->field.tqe_next))
>>>> +
>>>> #define QTAILQ_FOREACH_SAFE(var, head, field, next_var)               =
  \
>>>> for ((var) =3D ((head)->tqh_first);                               \
>>>> (var) && ((next_var) =3D ((var)->field.tqe_next), 1);     \
>>>>=20
>>>>=20
>>=20
>>> I still say this isn't required if the breakpoint loop is better struct=
ured.
>>=20
>> I can embed the use of QTAILQ into translate-block.c, but I wanted to ke=
ep the
>> implementation of breakpoint lists hidden behind the cpu_breakpoint API.

> I think using QTAILQ in the common main loop is better than twisting the =
logic
> so that the loop is unnaturally split into a subroutine.

Ok, then I'll integrate that into the new series.

Thanks,
  Lluis
