Received: from eggs.gnu.org ([2001:4830:134:3::10]:51117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWdpd-0001WM-ML
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWdpa-0007Kn-EJ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:55:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16377)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWdpY-0007CL-HF
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 03:55:53 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <154419994154.27028.14774494243513273923.stgit@gimli.home>
	<154420088248.27028.3919592169648338038.stgit@gimli.home>
	<16f2e753-4e80-0acc-d35a-75c6eb5a8f54@redhat.com>
Date: Tue, 11 Dec 2018 09:55:47 +0100
In-Reply-To: <16f2e753-4e80-0acc-d35a-75c6eb5a8f54@redhat.com> (Eric Blake's
	message of "Mon, 10 Dec 2018 16:00:57 -0600")
Message-ID: <874lbkbfxo.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] QAPI enum naming rules (was: [for-4.0 PATCH v4 4/9]
 qapi: Define PCIe link speed and width properties)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, Geoffrey McRae <geoff@hostfission.com>

Eric Blake <eblake@redhat.com> writes:

> On 12/7/18 10:41 AM, Alex Williamson wrote:
>> Create properties to be able to define speeds and widths for PCIe
>> links.  The only tricky bit here is that our get and set callbacks
>> translate from the fixed QAPI automagic enums to those we define
>> in PCI code to represent the actual register segment value.
>>
>> Cc: Eric Blake <eblake@redhat.com>
>> Tested-by: Geoffrey McRae <geoff@hostfission.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
[...]
>> +++ b/qapi/common.json
>> @@ -127,6 +127,48 @@
>>   { 'enum': 'OffAutoPCIBAR',
>>     'data': [ 'off', 'auto', 'bar0', 'bar1', 'bar2', 'bar3', 'bar4', 'bar5' ] }
>>   +##
>> +# @PCIELinkSpeed:
>> +#
>> +# An enumeration of PCIe link speeds in units of GT/s
>> +#
>> +# @2_5: 2.5GT/s
>> +#
>> +# @5: 5.0GT/s
>> +#
>> +# @8: 8.0GT/s
>> +#
>> +# @16: 16.0GT/s
>> +#
>> +# Since: 4.0
>> +##
>> +{ 'enum': 'PCIELinkSpeed',
>> +  'data': [ '2_5', '5', '8', '16' ] }
>
> QAPI enums are special-cased to allow starting with digits, thanks to
> QKeyCode.  I don't know if we are trying to avoid adding yet more of
> those, but the fact that you didn't have to whitelist them means that
> we are at least not forcibly limiting the use of leading digits in new
> enums.

Correct.  Enumeration values are a documented exception to the naming
rules:

    All names must begin with a letter, and contain only ASCII letters,
    digits, hyphen, and underscore.  There are two exceptions: enum values
    may start with a digit, and names that are downstream extensions (see
    section Downstream extensions) start with underscore.

We have naming rules for two reasons: (1) consistency and aesthetics,
and (2) a reasonably sane mapping to C identifiers.

Permitting both hyphen and underscore goes against (2).  The rules were
retrofitted after that horse had long bolted.  Same for the downstream
extension exception.

The enum value exception does not go against (2), because the mapping to
C identifiers prefixes the enum name.

(1) and (2) don't always pull in the same direction.  For instance, one
could argue that aesthetics favor '2.5' over '2_5'.  However, permitting
periods (everywhere or just in enum values) would go against (2),
because it creates new ways for the mapping to C identifiers to create
clashes.  We can certainly debate this.
