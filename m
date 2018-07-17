Received: from eggs.gnu.org ([2001:4830:134:3::10]:35196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffTdC-0000pZ-DY
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffTdB-0001gp-C5
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:19:22 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffTdB-0001gJ-6A
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:19:21 -0400
Received: by mail-oi0-x244.google.com with SMTP id l10-v6so3501594oii.0
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 10:19:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87wottyeqk.fsf@secure.mitica>
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-2-quintela@redhat.com>
	<20180717124646.GP18603@redhat.com> <87wottyeqk.fsf@secure.mitica>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 18:18:59 +0100
Message-ID: <CAFEAcA8S1rG4X37Qmgk5YawCh32p=yw7o=22uQuZQWJMBBke7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Juan Quintela <quintela@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 17 July 2018 at 18:05, Juan Quintela <quintela@redhat.com> wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>> On Tue, Jul 17, 2018 at 01:33:38PM +0200, Juan Quintela wrote:
>>> If you don't want to compile everything, you configure
>>> config-devices.mak.  And then make clean remove it, and make will
>>> create a default one without your configuration.  Fix it by not
>>> removing it.
>>>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> ---
>>>  Makefile | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 2da686be33..2ffbcde323 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -751,7 +751,7 @@ clean:
>>>      if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
>>>      rm -f $$d/qemu-options.def; \
>>>          done
>>> -    rm -f $(SUBDIR_DEVICES_MAK) config-all-devices.mak
>>> +    rm -f config-all-devices.mak
>>>
>>>  VERSION ?=3D $(shell cat VERSION)
>>
>> This feels wrong to me.  If 'make' is creating config-devices.mak, then
>> either 'make clean' or 'make distclean' must remove it. So if you remove
>> it here, it should be added to distclean instead.
>
> I can agree with putting it on distclean.
>
> make don't put it there if it is already there.  My use case is that I
> have several build trees from the same source three:
>
> - x86_64-softmmu with minimal set of devices (the ones that I use)
> - x86_64-softmmu with everything under the sun
> - everything that can be compiled in in fedora
>
> for the 1st case, I am interested that it is fast, so I edit the
> x86_64-softmmu/config-device.mak.  But if I do a make clean for any
> reason, I lost my changes.

I think the problem here is that we're confused about whether
config-devices.mak should be a user-editable file or just
part of our build process. Personally I think we should go
for the latter, ie if there are useful use cases that
currently you need to edit the file to achieve, we should
provide a better mechanism for doing them.

thanks
-- PMM
