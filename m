Received: from eggs.gnu.org ([209.51.188.92]:35842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLXwk-00038m-Gf
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLXu9-0001EK-5D
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:55:02 -0400
References: <1552300145-12526-1-git-send-email-thuth@redhat.com>
	<6d46de0f-a443-2c90-334b-edd34325ac16@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <817b41fa-063e-7008-af0a-6758112bca67@redhat.com>
Date: Tue, 30 Apr 2019 20:54:51 +0200
MIME-Version: 1.0
In-Reply-To: <6d46de0f-a443-2c90-334b-edd34325ac16@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Remove old
 *-config-devices.mak.d files when running configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 11/03/2019 17.21, Eric Blake wrote:
> On 3/11/19 5:29 AM, Thomas Huth wrote:
>> When running "make" in a build directory from the pre-Kconfig merge ti=
me,
>> the build process currently fails with:
>>
>>  make: *** No rule to make target `.../default-configs/pci.mak',
>>   needed by `aarch64-softmmu/config-devices.mak'.  Stop.
>>
>> To make sure that this problem at least goes away when the user runs
>> "configure" (or "sh config.status") again, we have to make sure that
>> we re-generate the .mak.d files. Thus remove the old stale files
>> while running the configure script.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  configure | 3 +++
>>  1 file changed, 3 insertions(+)
>=20
> What are the conditions for make deciding it needs to rerun
> config.status? Are end users still going to get 'make' failing with the
> cryptic message (where we just advise on-list and on-wiki to
> './config.status' to fix it), or is there a way to build in a dependenc=
y
> so that the makefile itself knows that if config.status has to be rerun=
,
> that takes priority over any other rule that depends on .mak files?

I just noticed that I never replied to this mail so far, sorry!

The conditions for rerunning config.status can be found in the Makefile:

config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH)/VE=
RSION
        @echo $@ is out-of-date, running configure
	...

At least we change VERSION regularly, so while not being perfect, the pro=
blem
should go away after a while with this patch. Not sure whether there is a=
 better
way to do this - maybe depend on the files in default-configs/, too? Or m=
aybe we
could simply bump VERSION from x.y.50 to x.y.51 the next time when we eve=
r hit
such a problem again...?

 Thomas
