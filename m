Received: from eggs.gnu.org ([2001:4830:134:3::10]:37024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffTl1-0004UN-6v
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffTkx-0000KH-7i
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:27:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49598 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffTkx-0000Jh-2h
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:27:23 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA8S1rG4X37Qmgk5YawCh32p=yw7o=22uQuZQWJMBBke7Q@mail.gmail.com>
	(Peter Maydell's message of "Tue, 17 Jul 2018 18:18:59 +0100")
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-2-quintela@redhat.com>
	<20180717124646.GP18603@redhat.com> <87wottyeqk.fsf@secure.mitica>
	<CAFEAcA8S1rG4X37Qmgk5YawCh32p=yw7o=22uQuZQWJMBBke7Q@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Tue, 17 Jul 2018 19:27:19 +0200
Message-ID: <87k1ptydqg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/25] configure: We don't want to clean
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 17 July 2018 at 18:05, Juan Quintela <quintela@redhat.com> wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>>> On Tue, Jul 17, 2018 at 01:33:38PM +0200, Juan Quintela wrote:
>>>> If you don't want to compile everything, you configure
>>>> config-devices.mak.  And then make clean remove it, and make will
>>>> create a default one without your configuration.  Fix it by not
>>>> removing it.
>>>>
>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>> ---
>>>>  Makefile | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Makefile b/Makefile
>>>> index 2da686be33..2ffbcde323 100644
>>>> --- a/Makefile
>>>> +++ b/Makefile
>>>> @@ -751,7 +751,7 @@ clean:
>>>>      if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
>>>>      rm -f $$d/qemu-options.def; \
>>>>          done
>>>> -    rm -f $(SUBDIR_DEVICES_MAK) config-all-devices.mak
>>>> +    rm -f config-all-devices.mak
>>>>
>>>>  VERSION ?=3D $(shell cat VERSION)
>>>
>>> This feels wrong to me.  If 'make' is creating config-devices.mak, then
>>> either 'make clean' or 'make distclean' must remove it. So if you remove
>>> it here, it should be added to distclean instead.
>>
>> I can agree with putting it on distclean.
>>
>> make don't put it there if it is already there.  My use case is that I
>> have several build trees from the same source three:
>>
>> - x86_64-softmmu with minimal set of devices (the ones that I use)
>> - x86_64-softmmu with everything under the sun
>> - everything that can be compiled in in fedora
>>
>> for the 1st case, I am interested that it is fast, so I edit the
>> x86_64-softmmu/config-device.mak.  But if I do a make clean for any
>> reason, I lost my changes.
>
> I think the problem here is that we're confused about whether
> config-devices.mak should be a user-editable file or just
> part of our build process. Personally I think we should go
> for the latter, ie if there are useful use cases that
> currently you need to edit the file to achieve, we should
> provide a better mechanism for doing them.

I agree with the better mechanism, but until them this is the only way
to "choose" what devices to compile in.  It is a very bad mechanism, but
it is the only one that we have right now.

On a general level, for devices that are quite well isolated, it works
quite well.  But for the rest of the things, it is kind of messy.
- No dependencies
  So, if you look at the generated x86_64-softmmu/config-devices,mak,
  you can see that we define CONFIG_SCSI=3Dy at least three times
- No way to show that dependencies at the C level, so we can only
  compile in/out at the file level
- simple things like pc-speaker, msmouse or vmport, you can't compile
  out, because they are created by code, not by
  qom/configuration/whatever.

On the other hand, sometimes it looks like I am the only user that use
this.  The original reason for this was to be able to compile out
drivers that downstream don't care about.  There were a couple of
intents to integrate with something like kernel kconfig, but I think
that we never end integrating anything from there.

Later, Juan.
