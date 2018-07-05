Received: from eggs.gnu.org ([2001:4830:134:3::10]:59311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fb57g-0002VZ-NJ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fb57c-0000oc-La
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:20:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50194 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fb57c-0000iu-FB
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:20:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DF0987AAD
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 14:20:35 +0000 (UTC)
References: <20180705123929.GB16293@redhat.com>
	<20180705125231.GD16293@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d154245b-46c0-58b0-b6f9-1f1313634c80@redhat.com>
Date: Thu, 5 Jul 2018 16:20:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180705125231.GD16293@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Byte ordering of VM Generation ID in Windows VMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, berrange@redhat.com, jferlan@redhat.com

Hi Rich,

On 07/05/18 14:52, Richard W.M. Jones wrote:
> On Thu, Jul 05, 2018 at 01:39:29PM +0100, Richard W.M. Jones wrote:
>> I was doing a bit of investigation around how different hypervisors
>> handle the VM Generation ID feature.  QEMU's behaviour seems quite
>> strange, I wonder if this is a bug or expected?
>>
>> (1) I booted a Windows 2016 VM with:
>>
>>   qemu-system-x86_64 -M pc,accel=kvm -m 2G -hda w2k16-mincore.img \
>>       -device vmgenid,guid=01020304-0506-0708-090a-0b0c0d0e0f00,id=vmgenid0
>>
>> (2) Inside the guest I used the VMGENID.EXE program from:
>>
>>   https://bugzilla.redhat.com/show_bug.cgi?id=1598350#c3
>>   https://docs.microsoft.com/en-gb/windows/desktop/HyperV_v2/virtual-machine-generation-identifier
>>
>> Note this is self-compiled using mingw64-g++ (not using Visual Studio
>> which I don't have available), but I don't believe that could have
>> caused the problem.
>>
>> (3) The program prints:
>>
>>   VmCounterValue: 708050601020304:f0e0d0c0b0a09
>>
>> To make it easier to see, this is the same number but zero-extended:
>>
>>   VmCounterValue: 07 08 05 06 01 02 03 04 : 00 0f 0e 0d 0c 0b 0a 09
>>                   \________ LOW ________/   \_______ HIGH _______/
>>                             WORD                     WORD
>>
>> As you can see it looks like there is no clear relationship between
>> the order of the bytes in the guid= parameter and the order that they
>> are seen by Windows.
>
> OK after examining util/uuid.c and the qemu_uuid_bswap function,
> I sort of see what's going on here.
>
> FWIW other hypervisors seem to store these as two 64 bit integers.

This is a bit tricky. Please refer to the following:

* https://bugzilla.redhat.com/show_bug.cgi?id=1118834#c21
* http://mid.mail-archive.com/c052d05e-71a5-1a6a-f34f-17d14167c2f6@redhat.com

in particular steps (8) + (9), and (15) + (16).

The QEMU device model takes the UUID (GUID) in textual representation
and stores it in guest memory in little endian binary UUID
representation. Historically, components of the UUID used to be encoded
in big endian, when represented in binary; however, as e.g. the SMBIOS
spec states (in "7.2.1 System -- UUID"), Microsoft uses little endian
encoding, for representing those fields of the UUID, in binary, that are
not simple byte arrays. (This has BTW leaked into other domains, for
example ACPI and UEFI).

In turn, the test program that you used didn't print the binary value in
either UUID format or raw byte dump format -- instead, it interpreted
the first 8 bytes as a little-endian uint64_t, and the second 8 bytes as
another uint64_t.

Applied to your example, we have:

  01020304-0506-0708-090a-0b0c0d0e0f00

  time_low:                  0x01020304 (DWORD)
  time_mid:                  0x0506 (WORD)
  time_hi_and_version:       0x0708 (WORD)
  clock_seq_hi_and_reserved: 0x09 (BYTE)
  clock_seq_low:             0x0a (BYTE)
  Node:                      0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x00 (BYTE[6])

The DWORD and WORD fields are sensitive to endianness. When using
little-endian, the full raw representation, and the uint64_t
interpretations will be:

  time_low                time_mid    time_hi_and_version  clock_seq_hi_and_reserved  clock_seq_low         Node
  ----------------------  ----------  -------------------  -------------------------  --------------------  ----------------------------------
  0x04, 0x03, 0x02, 0x01, 0x06, 0x05, 0x08, 0x07,          0x09,                      0x0a,                 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x00
  -------------------------------------------------------  -----------------------------------------------------------------------------------
  uint64_t: 0x0708050601020304                             uint64_t: 0x000f0e0d0c0b0a09

QEMU does the right thing. If other hypervisors don't do this -- while
still taking and displaying the value in UUID / GUID textual format --,
they are wrong. The VMGENID spec from Microsoft
<http://go.microsoft.com/fwlink/?LinkId=260709> specifically mentions
"GUID".

Thanks,
Laszlo
