Received: from eggs.gnu.org ([209.51.188.92]:35399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr1dm-0006mA-5N
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr1dl-0000CQ-3l
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:23:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gr1dk-0000BV-SE
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:23:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so3795382wrx.9
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 06:23:56 -0800 (PST)
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-10-philmd@redhat.com>
	<CAFEAcA_ejg0yPkBZ_0-mgM5zgMHKqKe3SDGX0wMZ-neYC_Oy0A@mail.gmail.com>
	<e5dd8130-e041-7774-2141-cc506dee99f7@redhat.com>
	<94f74717-0bab-ea0a-e7cc-239a1b1136bf@comstyle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e8177680-28fc-1213-a8f7-a3b94ef92e15@redhat.com>
Date: Tue, 5 Feb 2019 15:23:53 +0100
MIME-Version: 1.0
In-Reply-To: <94f74717-0bab-ea0a-e7cc-239a1b1136bf@comstyle.com>
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
To: Brad Smith <brad@comstyle.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

Hi Brad,

On 2/5/19 2:57 PM, Brad Smith wrote:
> If someone could point me in the right direction as to how the image is
> created
> I could look at coming up with something newer. I would prefer that over
> some
> of the workarounds I've seen to date.

I'm not an OpenBSD user, so I'm more than happy if you can help the
upstream community to test QEMU codebase on this OS. Testing helps us to
avoid code rot.

What we currently use to run tests is the 'tests/vm/openbsd' script.
The script itself doesn't document how it was built, but looking at the
commit of his introduction fdfaa33291eb we have:

    The image is prepared following instructions as in:

    https://wiki.qemu.org/Hosts/BSD

Regards,

Phil.

> On 2/5/2019 8:42 AM, Philippe Mathieu-Daudé wrote:
>> Hi Peter,
>>
>> On 2/5/19 2:20 PM, Peter Maydell wrote:
>>> On Tue, 29 Jan 2019 at 17:57, Philippe Mathieu-Daudé
>>> <philmd@redhat.com> wrote:
>>>> Various iotests scripts (run via 'make check-block')  use bash
>>>> specific extentions.  OpenBSD comes with the Korn shell as default.
>>>> Install bash to be able to run those tests.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> ---
>>>>   tests/vm/openbsd | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
>>>> index 6263c8956b..e9c2a3f2c8 100755
>>>> --- a/tests/vm/openbsd
>>>> +++ b/tests/vm/openbsd
>>>> @@ -45,6 +45,8 @@ class OpenBSDVM(basevm.BaseVM):
>>>>           self.wait_ssh()
>>>>           sys.stderr.write("Disabling W^X on the build partition...\n")
>>>>           self.ssh_root_check("sed -E -i 's_(/tmp\ ffs)\ ([^\
>>>> ]*)_\\1 \\2,wxallowed_' /etc/fstab")
>>>> +        sys.stderr.write("Installing bash...\n")
>>>> +       
>>>> self.ssh_root_check("PKG_PATH=https://ftp.openbsd.org/pub/OpenBSD/6.1/packages/amd64
>>>> pkg_add bash")
>>>>           self.ssh_root("shutdown -p now")
>>>>           self.wait()
>>>>
>>> Wouldn't it make more sense to just update the image to include
>>> the necessary package, the same way we do with all QEMU's
>>> other build dependencies ?
>> Instead of updating the image, Daniel asked if we could upgrade this
>> image to a more recent release (to remove SDL1), but IIRC the outcome
>> was there is no manpower for that. Meanwhile, this kludge seems the
>> simplest way.
>> BTW This command is run once at image creation.
