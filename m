Received: from eggs.gnu.org ([209.51.188.92]:53877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr102-0007J2-8l
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr0zz-0005rA-DD
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:42:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gr0zz-0005mP-1N
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:42:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so3700807wmi.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 05:42:49 -0800 (PST)
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-10-philmd@redhat.com>
	<CAFEAcA_ejg0yPkBZ_0-mgM5zgMHKqKe3SDGX0wMZ-neYC_Oy0A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e5dd8130-e041-7774-2141-cc506dee99f7@redhat.com>
Date: Tue, 5 Feb 2019 14:42:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ejg0yPkBZ_0-mgM5zgMHKqKe3SDGX0wMZ-neYC_Oy0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/18] tests/vm/openbsd: Install Bash
 from the ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Brad Smith <brad@comstyle.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

Hi Peter,

On 2/5/19 2:20 PM, Peter Maydell wrote:
> On Tue, 29 Jan 2019 at 17:57, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Various iotests scripts (run via 'make check-block')  use bash
>> specific extentions.  OpenBSD comes with the Korn shell as default.
>> Install bash to be able to run those tests.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  tests/vm/openbsd | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
>> index 6263c8956b..e9c2a3f2c8 100755
>> --- a/tests/vm/openbsd
>> +++ b/tests/vm/openbsd
>> @@ -45,6 +45,8 @@ class OpenBSDVM(basevm.BaseVM):
>>          self.wait_ssh()
>>          sys.stderr.write("Disabling W^X on the build partition...\n")
>>          self.ssh_root_check("sed -E -i 's_(/tmp\ ffs)\ ([^\ ]*)_\\1 \\2,wxallowed_' /etc/fstab")
>> +        sys.stderr.write("Installing bash...\n")
>> +        self.ssh_root_check("PKG_PATH=https://ftp.openbsd.org/pub/OpenBSD/6.1/packages/amd64 pkg_add bash")
>>          self.ssh_root("shutdown -p now")
>>          self.wait()
>>
> 
> Wouldn't it make more sense to just update the image to include
> the necessary package, the same way we do with all QEMU's
> other build dependencies ?

Instead of updating the image, Daniel asked if we could upgrade this
image to a more recent release (to remove SDL1), but IIRC the outcome
was there is no manpower for that. Meanwhile, this kludge seems the
simplest way.
BTW This command is run once at image creation.
