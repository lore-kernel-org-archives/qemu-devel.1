Received: from eggs.gnu.org ([2001:4830:134:3::10]:39333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daLwg-0006aC-OA
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daLwd-0000ZP-Ja
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:01:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daLwd-0000Z6-D3
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:01:43 -0400
References: <20170726093136.13627-1-pbonzini@redhat.com>
	<20170726155118-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a98cf681-2f14-52f2-a5d0-b6273b21dfc3@redhat.com>
Date: Wed, 26 Jul 2017 15:01:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170726155118-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu PATCH for 2.10] i386: acpi: provide an XSDT
 instead of an RSDT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, seabios@seabios.org, lersek@redhat.com, lists@philjordan.eu, imammedo@redhat.com, phil@philjordan.eu, programmingkidx@gmail.com, kraxel@redhat.com

On 26/07/2017 14:52, Michael S. Tsirkin wrote:
> On Wed, Jul 26, 2017 at 11:31:36AM +0200, Paolo Bonzini wrote:
>> The tables that QEMU provides are not ACPI 1.0 compatible since commit
>> 77af8a2b95 ("hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve
>> guest OS support.", 2017-05-03).  This is visible with Windows 2000,
>> which refuses to parse the rev3 FADT and fails to boot.
>>
>> The recommended solution in this case is to build two FADTs, v1 being
>> pointed to by the RSDT and v3 by the XSDT.  However, we leave this task
>> to the firmware.  This patch simply switches the RSDT to the XSDT, which
>> is valid for all ACPI 2.0-friendly operating systems and also leaves
>> SeaBIOS the freedom to build an RSDT that points to the compatibility
>> FADT.
>>
>> When running Windows 2000 with an old BIOS, Windows would simply fall
>> back to a non-ACPI HAL; however, the plan should be to include a BIOS with
>> the new feature in 2.10.
>>
>> Reported-by: Programmingkid <programmingkidx@gmail.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> I'm not against this but let's do it for q35 only please. PC is a legacy
> machine type and let's just leave it alone.

I disagree with calling PC legacy when 99.99% of our users (probably
underestimated) are using it.  Doing it for PC only would mean switching
back from FADT rev3 to rev1, which is worse for guest OS support, and
adds yet another little-tested path.

Together with the corresponding SeaBIOS patch, this provides the best of
both worlds IMO.

Paolo
