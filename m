Received: from eggs.gnu.org ([2001:4830:134:3::10]:47511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAS7R-0000ma-Le
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 23:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAS7N-00067p-OJ
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 23:26:21 -0400
References: <20180420181951.7252-1-ehabkost@redhat.com>
	<20180420181951.7252-2-ehabkost@redhat.com>
	<20180420195625.GF29865@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <96915f39-e4d4-6bf4-add7-6006107ddbb3@redhat.com>
Date: Mon, 23 Apr 2018 05:26:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180420195625.GF29865@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 01/24] qemu.py: Introduce _create_console()
 method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Amador Pahim <apahim@redhat.com>, Cleber Rosa <crosa@redhat.com>, Alistair Francis <alistair23@gmail.com>, Qemu-s390x list <qemu-s390x@nongnu.org>

On 20.04.2018 21:56, Eduardo Habkost wrote:
> On Fri, Apr 20, 2018 at 03:19:28PM -0300, Eduardo Habkost wrote:
>> From: Amador Pahim <apahim@redhat.com>
>>
>> This patch adds the QEMUMachine._create_console() method, which
>> returns a list with the chardev console device arguments to be
>> used in the qemu command line.
>>
>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>> [ehabkost: reword commit message]
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>  scripts/qemu.py | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 44 insertions(+), 5 deletions(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 08a3e9af5a..9e9d502543 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -55,7 +55,7 @@ class QEMUMachine(object):
[...]
>> +        chardev = 'socket,id=console,{address},server,nowait'
>> +        if console_address is None:
>> +            console_address = tempfile.mktemp()
>> +            chardev = chardev.format(address='path=%s' %
>> +                                     console_address)
>> +        elif isinstance(console_address, tuple):
>> +            chardev = chardev.format(address='host=%s,port=%s' %
>> +                                     (console_address[0],
>> +                                     console_address[1]))
>> +        else:
>> +            chardev = chardev.format(address='path=%s' % console_address)
>> +
>> +        self._console_address = console_address
>> +
>> +        device = '{dev_type},chardev=console'
>> +        if '86' in self._arch:
>> +            device = device.format(dev_type='isa-serial')
>> +        elif 'ppc' in self._arch:
>> +            device = device.format(dev_type='spapr-vty')
>> +        elif 's390x' in self._arch:
>> +            device = device.format(dev_type='sclpconsole')
> 
> Why do we need this? Why isn't -serial enough?

AFAIK, at least on s390x, -serial is not implemented and you need to
specify a sclpconsole device.

 Thomas
