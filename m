Received: from eggs.gnu.org ([2001:4830:134:3::10]:33191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNJg-0008LT-VJ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNJd-0001S2-Or
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:34:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35908 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faNJd-0001Rf-Iy
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:34:05 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
	<20180627163551.31610-8-marcandre.lureau@redhat.com>
	<87sh50bkno.fsf@dusky.pond.sub.org>
	<CAJ+F1CL1HMNoJQUBcUWPM0kZni4GtPdHQmVmtbdbk+KhyfkPrg@mail.gmail.com>
	<87r2kka19v.fsf@dusky.pond.sub.org>
	<CAJ+F1CL8BHh6K5Ds_AdnGAwuCHH-HoAAi+GLQMGGuNLMHfq1Nw@mail.gmail.com>
Date: Tue, 03 Jul 2018 17:34:00 +0200
In-Reply-To: <CAJ+F1CL8BHh6K5Ds_AdnGAwuCHH-HoAAi+GLQMGGuNLMHfq1Nw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 3 Jul 2018
	17:08:08 +0200")
Message-ID: <878t6s72qf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 07/15] qapi: add #if/#endif helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Jul 3, 2018 at 3:37 PM, Markus Armbruster <armbru@redhat.com> wro=
te:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>
>>> Hi
>>>
>>> On Tue, Jul 3, 2018 at 1:53 PM, Markus Armbruster <armbru@redhat.com> w=
rote:
>>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>>>
>>>>> Add helpers to wrap generated code with #if/#endif lines.
>>>>>
>>>>> Add QAPIGenCSnippet class to write C snippet code, make QAPIGenC
>>>>> inherit from it, for full C files with copyright headers etc.
>>>>
>>>> It's called QAPIGenCCode now.  Can touch up when I apply, along with
>>>> another instance below.
>>>>
>>>> Leaves the reader wondering *why* you need to splice QAPIGenCCode
>>>> between QAPIGen and QAPIGenC.  Becomes clear only in PATCH 10.
>>>> Providing the class now reduces code churn, but you should explain why.
>>>> Perhaps:
>>>>
>>>>   A later patch wants to use QAPIGen for generating C snippets rather
>>>>   than full C files with copyright headers etc.  Splice in class
>>>>   QAPIGenCCode between QAPIGen and QAPIGenC.
>>>
>>> sure, thanks
>>>
>>>>
>>>>> Add a 'with' statement context manager that will be used to wrap
>>>>> generator visitor methods.  The manager will check if code was
>>>>> generated before adding #if/#endif lines on QAPIGenCSnippet
>>>>> objects. Used in the following patches.
>>>>>
>>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>>> ---
>>>>>  scripts/qapi/common.py | 101 +++++++++++++++++++++++++++++++++++++++=
--
>>>>>  1 file changed, 97 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>>>>> index 1b56065a80..44eaf25850 100644
>>>>> --- a/scripts/qapi/common.py
>>>>> +++ b/scripts/qapi/common.py
>>>>> @@ -12,6 +12,7 @@
>>>>>  # See the COPYING file in the top-level directory.
>>>>>
>>>>>  from __future__ import print_function
>>>>> +from contextlib import contextmanager
>>>>>  import errno
>>>>>  import os
>>>>>  import re
>>>>> @@ -1974,6 +1975,40 @@ def guardend(name):
>>>>>                   name=3Dguardname(name))
>>>>>
>>>>>
>>>>> +def gen_if(ifcond):
>>>>> +    ret =3D ''
>>>>> +    for ifc in ifcond:
>>>>> +        ret +=3D mcgen('''
>>>>> +#if %(cond)s
>>>>> +''', cond=3Difc)
>>>>> +    return ret
>>>>> +
>>>>> +
>>>>> +def gen_endif(ifcond):
>>>>> +    ret =3D ''
>>>>> +    for ifc in reversed(ifcond):
>>>>> +        ret +=3D mcgen('''
>>>>> +#endif /* %(cond)s */
>>>>> +''', cond=3Difc)
>>>>> +    return ret
>>>>> +
>>>>> +
>>>>> +def wrap_ifcond(ifcond, before, after):
>>>>
>>>> Looks like a helper method.  Name it _wrap_ifcond?
>>>
>>> Not fond of functions with _. Iirc, it was suggested by a linter to
>>> make it a top-level function. I don't mind if you change it on commit.
>>
>> It's just how Python defines a module's public names.  I don't like the
>> proliferation of leading underscores either, but I feel it's best to go
>> with the flow here.
>
> ok
>
>>
>>>>> +    if ifcond is None or before =3D=3D after:
>>>>> +        return after
>>>>
>>>> The before =3D=3D after part suppresses empty conditionals.  Suggest
>>>>
>>>>            return after            # suppress empty #if ... #endif
>>>>
>>>> The ifcond is None part is suppresses "non-conditionals".  How can this
>>>> happen?  If it can't, let's drop this part.
>>>
>>> because the function can be called without additional checks on ifcond
>>> is None. I don't see what would be the benefit in moving this to the
>>> caller responsibility.
>>
>> Why stop at None?  Why not empty string?  Empty containers other than
>> []?  False?  Numeric zero?
>>
>> To answer my own question: because a precise function signatures reduce
>> complexity.  "The first argument is a list of strings, no ifs, no buts"
>> is simpler than "the first argument may be None, or a list of I don't
>> remember what exactly, but if you screw it up, the function hopefully
>> throws up before it does real damage" ;)
>
> So you prefer if not ifcond or before =3D=3D after ? ok

I'd recommend

      +    if before =3D=3D after:
      +        return after

If we pass crap, we die in gen_if()'s for ifc in ifcond.  The difference
is now crap includes None.

>>>> Another non-conditional is [].  See below.
>>>>
>>>>> +
>>>>> +    assert after.startswith(before)
>>>>> +    out =3D before
>>>>> +    added =3D after[len(before):]
>>>>> +    if added[0] =3D=3D '\n':
>>>>> +        out +=3D '\n'
>>>>> +        added =3D added[1:]
>>>>
>>>> The conditional adjusts vertical space around #if.  This might need
>>>> tweaking, but let's not worry about that now.
>>>>
>>>>> +    out +=3D gen_if(ifcond)
>>>>> +    out +=3D added
>>>>> +    out +=3D gen_endif(ifcond)
>>>>
>>>> There's no similar adjustment for #endif.  Again, let's not worry about
>>>> that now.
>>>>
>>>>> +    return out
>>>>> +
>>>>> +
>>>>
>>>> Since gen_if([]) and gen_endif([]) return '', wrap_ifcond([], before,
>>>> after) returns after.  Okay.
>>>>
>>>>>  def gen_enum_lookup(name, values, prefix=3DNone):
>>>>>      ret =3D mcgen('''
>>>>>
>>>>> @@ -2064,6 +2099,7 @@ class QAPIGen(object):
>>>>>      def __init__(self):
>>>>>          self._preamble =3D ''
>>>>>          self._body =3D ''
>>>>> +        self._start_if =3D None
>>>>>
>>>>>      def preamble_add(self, text):
>>>>>          self._preamble +=3D text
>>>>> @@ -2071,6 +2107,25 @@ class QAPIGen(object):
>>>>>      def add(self, text):
>>>>>          self._body +=3D text
>>>>>
>>>>> +    def start_if(self, ifcond):
>>>>> +        assert self._start_if is None
>>>>> +
>>>>
>>>> Let's drop this blank line.
>>>
>>> I prefer to have preconditions separated from the code, but ok
>>
>> I sympathize, but not if both are one-liners.
>
> ok
>
>>
>>>>
>>>>> +        self._start_if =3D (ifcond, self._body, self._preamble)
>>>>
>>>> It's now obvious that you can't nest .start_if() ... .endif().  Good.
>>>>
>>>>> +
>>>>> +    def _wrap_ifcond(self):
>>>>> +        pass
>>>>> +
>>>>> +    def end_if(self):
>>>>> +        assert self._start_if
>>>>> +
>>>>
>>>> Let's drop this blank line.
>>>>
>>>>> +        self._wrap_ifcond()
>>>>> +        self._start_if =3D None
>>>>> +
>>>>> +    def get_content(self, fname=3DNone):
>>>>> +        assert self._start_if is None
>>>>> +        return (self._top(fname) + self._preamble + self._body
>>>>> +                + self._bottom(fname))
>>>>> +
>>>>>      def _top(self, fname):
>>>>>          return ''
>>>>>
>>>>
>>>> Note for later: all this code has no effect unless ._wrap_ifcond() is
>>>> overridden.
>>>>
>>>>> @@ -2091,8 +2146,7 @@ class QAPIGen(object):
>>>>>              f =3D open(fd, 'r+', encoding=3D'utf-8')
>>>>>          else:
>>>>>              f =3D os.fdopen(fd, 'r+')
>>>>> -        text =3D (self._top(fname) + self._preamble + self._body
>>>>> -                + self._bottom(fname))
>>>>> +        text =3D self.get_content(fname)
>>>>>          oldtext =3D f.read(len(text) + 1)
>>>>>          if text !=3D oldtext:
>>>>>              f.seek(0)
>>>>> @@ -2101,10 +2155,49 @@ class QAPIGen(object):
>>>>>          f.close()
>>>>>
>>>>>
>>>>> -class QAPIGenC(QAPIGen):
>>>>> +@contextmanager
>>>>> +def ifcontext(ifcond, *args):
>>>>> +    """A 'with' statement context manager to wrap with start_if()/en=
d_if()
>>>>>
>>>>> -    def __init__(self, blurb, pydoc):
>>>>> +    *args: variable length argument list of QAPIGen
>>>>
>>>> Perhaps: any number of QAPIGen objects
>>>>
>>>
>>> sure
>>>
>>>>> +
>>>>> +    Example::
>>>>> +
>>>>> +        with ifcontext(ifcond, self._genh, self._genc):
>>>>> +            modify self._genh and self._genc ...
>>>>> +
>>>>> +    Is equivalent to calling::
>>>>> +
>>>>> +        self._genh.start_if(ifcond)
>>>>> +        self._genc.start_if(ifcond)
>>>>> +        modify self._genh and self._genc ...
>>>>> +        self._genh.end_if()
>>>>> +        self._genc.end_if()
>>>>> +
>>>>
>>>> Can we drop this blank line?
>>>>
>>>
>>> I guess we can, I haven't tested the rst formatting this rigorously.
>>> Hopefully the linter does it.
>>>
>>>>> +    """
>>>>> +    for arg in args:
>>>>> +        arg.start_if(ifcond)
>>>>> +    yield
>>>>> +    for arg in args:
>>>>> +        arg.end_if()
>>>>> +
>>>>> +
>>>>> +class QAPIGenCCode(QAPIGen):
>>>>> +
>>>>> +    def __init__(self):
>>>>>          QAPIGen.__init__(self)
>>>>> +
>>>>> +    def _wrap_ifcond(self):
>>>>> +        self._body =3D wrap_ifcond(self._start_if[0],
>>>>> +                                 self._start_if[1], self._body)
>>>>> +        self._preamble =3D wrap_ifcond(self._start_if[0],
>>>>> +                                     self._start_if[2], self._preamb=
le)
>>>>
>>>> Can you explain why you put the machinery for conditionals in QAPIGen
>>>> and not QAPIGenCCode?
>>>
>>> Iirc, this has to do with the fact that QAPIGenDoc is used for
>>> visiting, and thus QAPIGen start_if()/end_if() could be handled there,
>>
>> Can you point me to calls of .start_if(), .end_if(), .get_content() for
>> anything but QAPIGenCCode and its subtypes?
>>
>>> while we only want to generate #ifdef wrapping in QAPIGenCCode. I
>>> guess I could move more of start_if()/end_if() data to QAPIGenCCode
>>> (make them virtual / 'pass' in QAPIGen) Is that what you would like to
>>> see?
>>
>> If there are no such calls, we should simply move the whole shebang to
>> QAPIGenCCode.
>
> done

Does that mean I should expect v7 from you?

>> If there are such calls, the common supertype QAPIGen has to provide the
>> methods.
>>
>> If we expect subtypes other than QAPIGenCCode to implement conditional
>> code generation the same way, except for a different ._wrap_ifcond(),
>> then the patch is okay as is.
>>
>> If we don't, the transformation you described looks like an improvement
>> to me, because it keeps the actual code closer together.
>>
>> What's your take on it?
>>
>> I think I could make the transformation when I apply.
>>
>>>>
>>>>> +
>>>>> +
>>>>> +class QAPIGenC(QAPIGenCCode):
>>>>> +
>>>>> +    def __init__(self, blurb, pydoc):
>>>>> +        QAPIGenCCode.__init__(self)
>>>>>          self._blurb =3D blurb
>>>>>          self._copyright =3D '\n * '.join(re.findall(r'^Copyright .*'=
, pydoc,
>>>>>                                                    re.MULTILINE))
>>>>
