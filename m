Received: from eggs.gnu.org ([2001:4830:134:3::10]:36987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d6ZVo-0002Eu-IN
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d6ZVn-0006WQ-8J
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:26:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d6ZVm-0006WI-Sx
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:26:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A2F3C04B320
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 09:26:53 +0000 (UTC)
References: <CANHSq5DhUak9fVpvjG=VyeetP7VQudHwyEa4VevC21BuieSstw@mail.gmail.com>
	<20170303103919.GA2439@work-vm> <87o9xizhs1.fsf@dusky.pond.sub.org>
	<20170327163157.GA5424@work-vm>
	<CANHSq5Bvpm-ofhCVvReDcAPJYpfHTgu3qanT+kaJU3KH1MViNw@mail.gmail.com>
	<87efw3u903.fsf@dusky.pond.sub.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ae6f580f-da6a-c0cd-4fcc-ec71dff537f4@redhat.com>
Date: Fri, 5 May 2017 17:26:45 +0800
MIME-Version: 1.0
In-Reply-To: <87efw3u903.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2] migration: expose qemu_announce_self()
 via qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Germano Veit Michel <germano@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Jose Quintela Carreira <quintela@redhat.com>, qemu-devel@nongnu.org



On 2017=E5=B9=B405=E6=9C=8805=E6=97=A5 14:13, Markus Armbruster wrote:
> Germano Veit Michel <germano@redhat.com> writes:
>
>> Hi guys,
>>
>> Finally got some time to prepare V3.
>>
>> First of all Dave's trick is really useful to test it:
>>
>> ./x86_64-softmmu/qemu-system-x86_64 -nographic -nodefaults -netdev
>> user,id=3Dnetuser -object filter-dump,id=3Ddump,netdev=3Dnetuser,file=3D=
foo2
>> -device e1000,netdev=3Dnetuser,mac=3D00:11:22:33:44:55 -monitor stdio
>> QEMU 2.8.91 monitor - type 'help' for more information
>> (qemu) announce-self
>> (qemu) announce-self
>> (qemu) qemu-system-x86_64: terminating on signal 2
>>
>> tshark -r foo2 | grep RARP
>>      1   0.000000 Cimsys_33:44:55 =E2=86=92 Broadcast    RARP 60 Who i=
s
>> 00:11:22:33:44:55? Tell 00:11:22:33:44:55
>>      2   0.050017 Cimsys_33:44:55 =E2=86=92 Broadcast    RARP 60 Who i=
s
>> 00:11:22:33:44:55? Tell 00:11:22:33:44:55
>>      3   0.200077 Cimsys_33:44:55 =E2=86=92 Broadcast    RARP 60 Who i=
s
>> 00:11:22:33:44:55? Tell 00:11:22:33:44:55
>>      4   0.450112 Cimsys_33:44:55 =E2=86=92 Broadcast    RARP 60 Who i=
s
>> 00:11:22:33:44:55? Tell 00:11:22:33:44:55
>>      5   0.800090 Cimsys_33:44:55 =E2=86=92 Broadcast    RARP 60 Who i=
s
>> 00:11:22:33:44:55? Tell 00:11:22:33:44:55
>>     13   5.583887 Cimsys_33:44:55 =E2=86=92 Broadcast    RARP 60 Who i=
s
>> 00:11:22:33:44:55? Tell 00:11:22:33:44:55
>>     14   5.633079 Cimsys_33:44:55 =E2=86=92 Broadcast    RARP 60 Who i=
s
>> 00:11:22:33:44:55? Tell 00:11:22:33:44:55
>>     15   5.783152 Cimsys_33:44:55 =E2=86=92 Broadcast    RARP 60 Who i=
s
>> 00:11:22:33:44:55? Tell 00:11:22:33:44:55
>>     16   6.033130 Cimsys_33:44:55 =E2=86=92 Broadcast    RARP 60 Who i=
s
>> 00:11:22:33:44:55? Tell 00:11:22:33:44:55
>>     17   6.383144 Cimsys_33:44:55 =E2=86=92 Broadcast    RARP 60 Who i=
s
>> 00:11:22:33:44:55? Tell 00:11:22:33:44:55
>>
>> Now for qtest:
>>
>> It is compiling and running my test:
>>
>>    [....]
>>    CC      tests/qmp-net-test.o
>>    LINK    tests/qmp-net-test
>>    [....]
>>    GTESTER check-qtest-x86_64
>>
>> /bin/sh -c printf "  %-7s %s\n" "GTESTER" "check-qtest-x86_64" &&
>> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3D=
qemu-img
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$((RANDOM % 255 + 1))} gtester -k=
 -q
>> -m=3Dquick [.....] tests/qmp-net-test [....]
>>
>> Weird is... is the test qemu running without NICs?
> Please show us test/qmp-net-test.c.
>
>> x86_64-softmmu/qemu-system-x86_64 -qtest unix:/tmp/qtest-17545.sock,no=
wait
>> -qtest-log /dev/null -qmp unix:/tmp/qtest-17545.qmp,nowait -machine
>> accel=3Dqtest -display none -M q35,accel=3Dtcg -chardev
>> file,id=3Dserial0,path=3D/tmp/qtest-boot-serial-HYHJ2e -no-shutdown -s=
erial
>> chardev:serial0 -device sga
>>
>> I was looking at this
>> http://events.linuxfoundation.org/sites/events/files/slides/Testing%20=
QEMU%20emulated%20devices%20using%20qtest.pdf
>> and it's pretty helpful. But I have no clues on how to actually check =
if
>> the RARP packets really go out on each NIC. Any idea on how to impleme=
nt
>> this or is the smoke test enough?
> I'd try to use filter-dump to capture the traffic, then compare the
> actual captured traffic to the expected one.

Or use a socket backend like virtio-net-test.c.

Thanks
