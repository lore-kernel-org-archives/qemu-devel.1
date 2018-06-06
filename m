Received: from eggs.gnu.org ([2001:4830:134:3::10]:56539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQhW0-0003gd-N9
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 19:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQhVx-0004Vm-7J
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 19:06:52 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:41485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQhVx-0004VY-0l
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 19:06:49 -0400
Received: by mail-ua0-x244.google.com with SMTP id a5-v6so5198329uao.8
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 16:06:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180606192731.6910-1-f4bug@amsat.org>
	<20180606200513.GY7451@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6a527693-33e6-813b-9fc5-b114aacc7668@amsat.org>
Date: Wed, 6 Jun 2018 20:06:43 -0300
MIME-Version: 1.0
In-Reply-To: <20180606200513.GY7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2] qmp.py: Fix exception parsing
 partial JSON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 06/06/2018 05:05 PM, Eduardo Habkost wrote:
> On Wed, Jun 06, 2018 at 04:27:31PM -0300, Philippe Mathieu-Daudé wrote:
>> The readline() call returns partial data.
> 
> How can this be reproduced?  Despite not being forbidden by the
> QMP specification, QEMU normally doesn't break QMP replies in
> multiple lines, and readline() is not supposed to return a
> partial line unless it encounters EOF.

$ git rev-parse HEAD
c1c2a435905ae76b159c573b0c0d6f095b45ebc6

config copy/pasted from:
https://wiki.qemu.org/index.php/Documentation/QMP#Trying_it
(now looking at it, it seems I'm mixing configs...)

$ cat qmp.conf
[chardev "qmp"]
  backend = "socket"
  path = "/tmp/qmp.sock"
  server = "on"
  wait = "off"
[mon "qmp"]
  mode = "control"
  chardev = "qmp"
  pretty = "on"

$ arm-softmmu/qemu-system-arm -M lm3s6965evb -kernel /dev/zero \
 -readconfig qmp.conf -S

> 
> 
>> Keep appending until the JSON buffer is complete.
>>
>> This fixes:
>>
>>     $ scripts/qmp/qmp-shell -v -p /tmp/qmp.sock
>>     Traceback (most recent call last):
>>       File "scripts/qmp/qmp-shell", line 456, in <module>
>>         main()
>>       File "scripts/qmp/qmp-shell", line 441, in main
>>         qemu.connect(negotiate)
>>       File "scripts/qmp/qmp-shell", line 284, in connect
>>         self._greeting = super(QMPShell, self).connect(negotiate)
>>       File "scripts/qmp/qmp.py", line 143, in connect
>>         return self.__negotiate_capabilities()
>>       File "scripts/qmp/qmp.py", line 71, in __negotiate_capabilities
>>         greeting = self.__json_read()
>>       File "scripts/qmp/qmp.py", line 85, in __json_read
>>         resp = json.loads(data)
>>       File "/usr/lib/python2.7/json/__init__.py", line 339, in loads
>>         return _default_decoder.decode(s)
>>       File "/usr/lib/python2.7/json/decoder.py", line 364, in decode
>>         obj, end = self.raw_decode(s, idx=_w(s, 0).end())
>>       File "/usr/lib/python2.7/json/decoder.py", line 380, in raw_decode
>>         obj, end = self.scan_once(s, idx)
>>     ValueError: Expecting object: line 1 column 3 (char 2)
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Since v1:
>> - addressed Daniel review: clean data after json.loads() succeeds
>> - add a XXX comment
>>
>> Daniel suggested this is due to blocking i/o.
>>
>> I'm sure there is a nicer/more pythonic way to do this, but this works for me,
>> sorry :)
> 
> It looks like there's no elegant solution for this:
> https://stackoverflow.com/a/21709058
> 
>>
>>  scripts/qmp/qmp.py | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
>> index 5c8cf6a056..14f0b48936 100644
>> --- a/scripts/qmp/qmp.py
>> +++ b/scripts/qmp/qmp.py
>> @@ -78,11 +78,18 @@ class QEMUMonitorProtocol(object):
>>          raise QMPCapabilitiesError
>>  
>>      def __json_read(self, only_event=False):
>> +        data = ""
>>          while True:
>> -            data = self.__sockfile.readline()
>> -            if not data:
>> +            tmp = self.__sockfile.readline()
>> +            if not tmp:
>>                  return
>> -            resp = json.loads(data)
>> +            data += tmp
>> +            try:
>> +                resp = json.loads(data)
>> +            except ValueError:
>> +                # XXX: blindly loop, even if QEMU ever sends malformed data
>> +                continue
> 
> I was going to suggest using json.JSONDecoder.raw_decode() and
> saving the remaining data in case we already read partial data
> for a second JSON message.
> 
> But the QMP specification says all messages are terminated with
> CRLF, so we we should never see the data for two different
> messages in a single readline() call.  Noting this in a comment
> wouldn't hurt, though.
> 
> The patch seems reasonable, but first I would like to understand
> how this bug can be triggered.
> 
>> +            data = ""
>>              if 'event' in resp:
>>                  self.logger.debug("<<< %s", resp)
>>                  self.__events.append(resp)
>> -- 
>> 2.17.1
>>
> 
