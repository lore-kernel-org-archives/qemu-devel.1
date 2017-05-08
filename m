Received: from eggs.gnu.org ([2001:4830:134:3::10]:33252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7fhv-0005Gd-1h
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7fht-000667-VM
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d7fht-000662-MC
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:15:57 -0400
References: <1493726062-31743-1-git-send-email-thuth@redhat.com>
	<20170505144837.GB14316@stefanha-x1.localdomain>
	<20170505145049.GM12773@redhat.com> <871srz7n9x.fsf@dusky.pond.sub.org>
	<5c08c6b2-f82f-8e75-622e-0b229971cd8b@redhat.com>
	<20170508094039.GG18871@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6725f67e-e86e-ab63-deff-04f7be8bbca9@redhat.com>
Date: Mon, 8 May 2017 12:15:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170508094039.GG18871@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Mark legacy option '-no-kvm' as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 08.05.2017 11:40, Daniel P. Berrange wrote:
> On Mon, May 08, 2017 at 11:14:00AM +0200, Thomas Huth wrote:
>> On 08.05.2017 10:42, Markus Armbruster wrote:
>>> "Daniel P. Berrange" <berrange@redhat.com> writes:
>>>
>>>> On Fri, May 05, 2017 at 03:48:37PM +0100, Stefan Hajnoczi wrote:
>>>>> On Tue, May 02, 2017 at 01:54:22PM +0200, Thomas Huth wrote:
>>>>>> '-no-kvm' was just a legacy convenience option for the users of
>>>>>> qemu-kvm, it never made sense in the normal QEMU tree since TCG is
>>>>>> the default here anyway. The option has also never been specified
>>>>>> in the QEMU docs and in the '--help' list, so likely hardly anybod=
y
>>>>>> knows about this option at all. I think we could get rid of this
>>>>>> without bothering anybody nowadays, but just in case, let's print
>>>>>> out a warning for a couple of releases first.
>>>>>>
>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>> ---
>>>>>>  vl.c | 4 +++-
>>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/vl.c b/vl.c
>>>>>> index d5ec87e..2d44621 100644
>>>>>> --- a/vl.c
>>>>>> +++ b/vl.c
>>>>>> @@ -3709,7 +3709,9 @@ int main(int argc, char **argv, char **envp)
>>>>>>                      exit(1);
>>>>>>                  }
>>>>>>                  break;
>>>>>> -             case QEMU_OPTION_no_kvm:
>>>>>> +            case QEMU_OPTION_no_kvm:
>>>>>> +                error_report("'-no-kvm' is depreacted, please use=
 "
>>>>>
>>>>> s/depreacted/deprecated/
>>>>
>>>> Should we have an dedicated  'error_deprecated(oldfeat, newfeat)' me=
thod
>>>> that prints a standardized message, as well as a -no-deprecated flag=
 that
>>>
>>> I hate flags starting with "no".  What about something like
>>> --suppress-deprecation-warnings?
>>>
>>>> turns off all the deprecation warnings. There's nothing more annoyin=
g than
>>>> an application that insists on spewing warnings to stdout that you k=
now
>>>> about, but aren't in a position to address any time soon.
>>>
>>> If we do that, we should consider having the warnings tell users how =
to
>>> suppress them, say "You can suppress this warning with
>>> --suppress-deprecation-warnings".
>>
>> IMHO we should not add such a flag. Otherwise people will simply alway=
s
>> turn it on and not only ignore this warning, but also all other
>> warnings. I think these warnings *have* to be annoying to make sure th=
at
>> people change their scripts.
>> (And if they "aren't in a position to address any time soon", they
>> likely also aren't in a position to add a
>> "--suppress-deprecation-warnings" parameter to their scripts either).
>=20
> That isn't really true. Adding a --suppress-deprecation-warnings flag d=
oes
> not change semantics of either QEMU, or the mgmt app and so would not h=
ave
> any coding or testing burden.  Rewriting the mgmt app code to generate =
the
> QEMU command line in a different way has significant overhead in both c=
ode
> and testing work, as well as potential to introduce semantic bugs.

OK, I think we were talking at crossed purposes here. I was thinking
about people who invoke QEMU directly or via a shell script, and you
apparently had libvirt and other management apps in mind (I should've
know that, sorry).

So yes, with libvirt or other compiled management apps in mind, it would
make sense to have an error_deprecated() function, I guess.
But ideally, we should only deprecate those interfaces in QEMU where
we're sure that libvirt already does not use them anymore anyway.
For example, in this specific case here, it should not matter. libvirt
indeed has some code to use the -no-kvm switch, but as far as I can see,
it probes the help output of QEMU for the switch before using it. Since
QEMU does not list this switch in its help text (I guess only qemu-kvm
did so), it should simply ignore it.

Anyway, since Paolo does not like to remove these trivial legacy
switches anyway, I'll stop here, so -no-kvm can stay where it is.

 Thomas
