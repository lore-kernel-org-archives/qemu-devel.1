Received: from eggs.gnu.org ([2001:4830:134:3::10]:60152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffTQ4-0001l6-RZ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffTPz-0007jC-TA
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:05:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49220 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffTPz-0007iV-Mk
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:05:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 498D2808255B
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 17:05:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180717124646.GP18603@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Tue, 17 Jul 2018 13:46:46 +0100")
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-2-quintela@redhat.com>
	<20180717124646.GP18603@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 17 Jul 2018 19:05:39 +0200
Message-ID: <87wottyeqk.fsf@secure.mitica>
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
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Tue, Jul 17, 2018 at 01:33:38PM +0200, Juan Quintela wrote:
>> If you don't want to compile everything, you configure
>> config-devices.mak.  And then make clean remove it, and make will
>> create a default one without your configuration.  Fix it by not
>> removing it.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/Makefile b/Makefile
>> index 2da686be33..2ffbcde323 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -751,7 +751,7 @@ clean:
>>  	if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
>>  	rm -f $$d/qemu-options.def; \
>>          done
>> -	rm -f $(SUBDIR_DEVICES_MAK) config-all-devices.mak
>> +	rm -f config-all-devices.mak
>>=20=20
>>  VERSION ?=3D $(shell cat VERSION)
>
> This feels wrong to me.  If 'make' is creating config-devices.mak, then
> either 'make clean' or 'make distclean' must remove it. So if you remove
> it here, it should be added to distclean instead.

I can agree with putting it on distclean.

make don't put it there if it is already there.  My use case is that I
have several build trees from the same source three:

- x86_64-softmmu with minimal set of devices (the ones that I use)
- x86_64-softmmu with everything under the sun
- everything that can be compiled in in fedora

for the 1st case, I am interested that it is fast, so I edit the
x86_64-softmmu/config-device.mak.  But if I do a make clean for any
reason, I lost my changes.

But I agree that it is ok to remove it on make distclean.

Thanks, Juan.
