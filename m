Received: from eggs.gnu.org ([2001:4830:134:3::10]:46616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fb7r2-0005ay-Qy
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fb7qy-0001SW-R7
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:15:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56194 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fb7qy-0001Rz-JY
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:15:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29C4B400ADE4
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 17:15:36 +0000 (UTC)
References: <20180705123929.GB16293@redhat.com>
	<20180705125231.GD16293@redhat.com>
	<d154245b-46c0-58b0-b6f9-1f1313634c80@redhat.com>
	<20180705164343.GE16293@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <eba002c2-a50d-7252-65fa-104194e31fe8@redhat.com>
Date: Thu, 5 Jul 2018 19:15:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180705164343.GE16293@redhat.com>
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
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, berrange@redhat.com, jferlan@redhat.com

On 07/05/18 18:43, Richard W.M. Jones wrote:
> On Thu, Jul 05, 2018 at 04:20:33PM +0200, Laszlo Ersek wrote:
>> QEMU does the right thing. If other hypervisors don't do this -- while
>> still taking and displaying the value in UUID / GUID textual format --,
>> they are wrong. The VMGENID spec from Microsoft
>> <http://go.microsoft.com/fwlink/?LinkId=260709> specifically mentions
>> "GUID".
> 
> The MSFT spec does mention GUID, but it seems to me that it's only
> using GUID as an incidental example -- ie. that you might use the VM
> Generation ID to generate a GUID.  Outside that example it
> consistently refers to the VM Gen ID as a 128-bit integer.  It also
> says that it could be used as a "high entropy random data source",
> which is not in fact true if it's a UUID.

I don't have additional points regarding whether Microsoft genuinely did
or didn't think of VMGENID in terms of UUID.

However, the fact that the fields of the *original* UUID definition have
been repurposed for fully random bytes is not an argument against. Just
because we nowadays populate all those bytes from a PRNG (sort-of),
thereby ignoring their original field names, we still call the structure
UUID and we still preserve the internal field boundaries. For example,
in UEFI (the spec), we have

typedef struct {
  UINT32 Data1;
  UINT16 Data2;
  UINT16 Data3;
  UINT8 Data4[8];
} EFI_GUID;

and in the edk2 codebase, whenever a new GUID is needed for any purpose,
we're supposed to get one by running "uuidgen". From the manual:

       There  are two types of UUIDs which uuidgen can generate: time-
       based UUIDs and random-based UUIDs.  By  default  uuidgen  will
       generate  a  random-based  UUID if a high-quality random number
       generator is present.  Otherwise, it will choose  a  time-based
       UUID.   It  is possible to force the generation of one of these
       two UUID types by using the -r or -t options.

> It has to be said that after reading the spec again [the MSFT spec,
> not qemu's spec] and what other hypervisors are doing, I'm not sure
> qemu is doing the right thing here.

That's the thing about specs -- interpretation. I've read the vmgenid
spec several times as well, and I've always understood it as Microsoft
meaning UUID / GUID as a primary representation for VMGENID. I may have
been biased by UUID/GUID usage in UEFI.

When the feature was being developed for QEMU, we struggled with the
interpretation of a good number of other bits as well; hence the
"Requirements" section of QEMU's spec: "this is how we understood it".
Without an open list to discuss things with Microsoft, sometimes we can
only guess what is a "likely faithful" interpretation, and test it in
practice.

I still believe QEMU's current interpretation is the right one; but I
can't prove it.

Laszlo
