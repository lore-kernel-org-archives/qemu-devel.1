Received: from eggs.gnu.org ([209.51.188.92]:41530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJzq2-0004oF-UE
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJzq2-0003dP-2m
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:20:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hJzq1-0003cm-Ql
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:20:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11B071244E2
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 12:20:21 +0000 (UTC)
References: <20190419075625.24251-1-thuth@redhat.com>
	<c0ce7a39-9e9f-a7be-c73b-a9c2c05da3af@redhat.com>
	<e0e3128d-371c-7812-d99f-77af15ef278b@redhat.com>
	<84638796-204e-3f43-3fe1-f5329e9cd466@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <201457a3-d297-16ce-e375-f6ede5679492@redhat.com>
Date: Fri, 26 Apr 2019 14:20:14 +0200
MIME-Version: 1.0
In-Reply-To: <84638796-204e-3f43-3fe1-f5329e9cd466@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-4.1 0/2] Fix ohci_die() and move PCI
 code to separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 26/04/2019 14.14, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/26/19 7:42 AM, Thomas Huth wrote:
>> On 26/04/2019 00.55, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi Thomas,
>>>
>>> On 4/19/19 9:56 AM, Thomas Huth wrote:
>>>> First patch fixes a problem with ohci_die(), second patch moves PCI =
code into
>>>> a separate file, so that the sysbus OHCI device can also be used wit=
hout
>>>> the dependency on the PCI code.
>>>>
>>>> v2: Split the patch into two patches, one for the ohci_die() fix and=
 one
>>>>     for the PCI code movement.
>>>
>>> Way cleaner. I wonder why you don't use a typedef for the void
>>> (*ohci_die_fn)(struct OHCIState *) prototype.
>>
>> It does not work in that case:
>>
>> typedef struct OHCIState {            // <-- struct OHCIState definiti=
on
>>     [...]
>>     uint32_t async_td;
>>     bool async_complete;
>>
>>     void (*ohci_die)(struct OHCIState *ohci); // <-- ohci_die definiti=
on
>> } OHCIState;                         // <-- typedef OHCIState definiti=
on
>>
>> The typedef is defined after the ohci_die entry.
>=20
> I was thinking of forward declaration:
>=20
> typedef struct OHCIState OHCIState;
>=20
> typedef void (ohci_die_fn)(OHCIState *ohci);

Could work, too, but I don't like typedeferities... so unless Gerd
forces me to use that here, I'd prefer to keep the patch in its current
shape.

 Thomas
