Received: from eggs.gnu.org ([2001:4830:134:3::10]:55045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZGqU-0002cr-Pw
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZGqU-0004Wn-0Z
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:59:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZGqT-0004WR-NR
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:59:41 -0500
References: <1545065857-31164-1-git-send-email-thuth@redhat.com>
	<20181217193522.GK7141@habkost.net>
	<20181217175701-mutt-send-email-mst@kernel.org>
	<6c52d22d-1fc6-3365-5194-25ea886228d6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b27b5b1-5752-06e0-95b5-ac8eebd1c42d@redhat.com>
Date: Tue, 18 Dec 2018 13:32:27 +0100
MIME-Version: 1.0
In-Reply-To: <6c52d22d-1fc6-3365-5194-25ea886228d6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [QEMU PATCH] hw/i386: Remove deprecated machines
 pc-0.10 and pc-0.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, libvir-list@redhat.com

On 18/12/18 09:06, Thomas Huth wrote:
> On 2018-12-17 23:57, Michael S. Tsirkin wrote:
>> On Mon, Dec 17, 2018 at 05:35:22PM -0200, Eduardo Habkost wrote:
>>> On Mon, Dec 17, 2018 at 05:57:37PM +0100, Thomas Huth wrote:
>>>> They've been deprecated for two releases and nobody complained that they
>>>> are still required anymore, so it's time to remove these now.
>>>> And while we're at it, mark the other remaining old 0.x machine types
>>>> as deprecated (since they can not properly be used for live-migration
>>>> anyway).
>>>
>>> Do you know why exactly they can't be used for live-migration?
> 
> I don't remember the gory details, but IIRC Paolo once said that when
> you live-migrate from a QEMU version < 1.3 and then reboot the guest, it
> crashes, ... or something similar. Maybe Paolo can give some details again?

Yes---due to the introduction of the memory API, the firmware is not
migrated correctly from source to destination.  On QEMU <1.3 the
0xf0000-0xfffff area is basically a copy of the higher
0xffff0000-0xffffffff area, while on more recent versions it is
initialized with zeroes and the firmware copies from 0xffff0000 to
0xf0000.  When you migrate from old to new QEMU, after reboot there's
nothing at 0xf0000 and bugs ensue.

Paolo
