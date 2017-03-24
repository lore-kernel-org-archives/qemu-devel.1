Received: from eggs.gnu.org ([2001:4830:134:3::10]:55722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1crMWI-0001cW-PC
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1crMWF-00021p-Mn
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:32:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1crMWF-00021j-H2
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:32:31 -0400
References: <20170323212848.8492-1-ehabkost@redhat.com>
	<20170323212848.8492-2-ehabkost@redhat.com>
	<0596af14-a95c-edbf-1441-2f1a39bdff99@suse.com>
	<CAFEAcA8Wif2DshJ1YEbxBU4MMY3W0r2U036+4qqL8YzWAuNzJg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6501b2f4-421c-b41c-260a-c043144cd395@redhat.com>
Date: Fri, 24 Mar 2017 11:32:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Wif2DshJ1YEbxBU4MMY3W0r2U036+4qqL8YzWAuNzJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/4] [UNTESTED] xen: Don't force
 has_dynamic_sysbus on machine class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Juergen Gross <jgross@suse.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 24.03.2017 11:09, Peter Maydell wrote:
> On 24 March 2017 at 08:23, Juergen Gross <jgross@suse.com> wrote:
>> On 23/03/17 22:28, Eduardo Habkost wrote:
>>> The xen-backend devices created by the Xen code are not supposed
>>> to be treated as dynamic sysbus devices. This is an attempt to
>>> change that and see what happens, but I couldn't test it because
>>> I don't have a Xen host set up.
>>>
>>> If this patch breaks anything, this means we have a bug in
>>> foreach_dynamic_sysbus_device(), which is supposed to return only
>>> devices created using -device.
>>>
>>> The original code that sets has_dynamic_sysbus was added by
>>> commit 3a6c9172ac5951e6dac2b3f6cbce3cfccdec5894, but I don't see
>>> any comment explaining why it was necessary.
>>
>> xen-backend devices are created via qmp commands when attaching new
>> pv-devices to a domain. They can be dynamically removed, too. Setting
>> has_dynamic_sysbus was necessary to support this feature.
> 
> This seems like it ought to be handled by marking the xen-backend
> devices as being ok-to-dynamically-create somehow, not by marking
> the machine as supporting dynamic-sysbus (which it doesn't).
> Maybe we don't have the necessary support code to do that though?

Do the xen devices have to be sysbus devices? If no, I think you could
change them to be of type TYPE_DEVICE nowadays - TYPE_DEVICE can be
instantiated with "-device" nowadays, too. That's what we do with the
spapr-rng device for example (see hw/ppc/spapr_rng.c).

 Thomas
