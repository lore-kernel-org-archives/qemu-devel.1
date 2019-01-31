Received: from eggs.gnu.org ([209.51.188.92]:55991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpKko-0005vx-Re
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpKko-0007S1-5E
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:24:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpKkn-0007RF-VM
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:24:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so5045580wra.6
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 14:24:13 -0800 (PST)
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-42-git-send-email-pbonzini@redhat.com>
	<1bd28f71-6c37-2739-f181-4d8796fedb2c@redhat.com>
	<037c6301-8c15-2bd9-3b34-4bb948661138@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6cc1cdd3-edec-c30e-6524-6585dcf007f2@redhat.com>
Date: Thu, 31 Jan 2019 23:24:11 +0100
MIME-Version: 1.0
In-Reply-To: <037c6301-8c15-2bd9-3b34-4bb948661138@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 41/52] isa: express dependencies with
 kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

On 1/31/19 11:14 PM, Paolo Bonzini wrote:
> On 31/01/19 22:22, Philippe Mathieu-Daudé wrote:
>> I kinda disagree with the SuperIO generated configs here, but partly my
>> fault because the previous Makefile.objs missed the CONFIG_ISA_SUPERIO
>> (I missed to review eae2e2e96bf from Thomas where is introduced
>> CONFIG_SMC37C669).
>> So introducing ISA_SUPERIO simplifies this files and SouthBridge
>> devices. I'm not sure how to provide this patch:
> 
> The problem is different SuperIO chips can have or lack
> floppy/serial/parallel, and so they end up having different dependencies.
> 
> Config symbols are a tool to generate working QEMUs (where working =
> build and pass device-introspect-test more or less), they needn't
> reflect precisely the topology of the machine.

The model implementation is:
- abstract SuperIO parent which can instantiate all configs,
- child implementation.

Childs require their parent, and even if the parent will instantiate
them without all properties, the parent needs to link with them.

In short, if a SuperIO child requires ISA_SUPERIO, it also requires to
link to serial/parallel/floppy/ide.

That's why I prefer the explicit dependencies.

Oh, actually if we correctly use the TYPE_XXX names, it might link.
The only problem would be trying to instantiate a device via QMP then?
