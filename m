Received: from eggs.gnu.org ([2001:4830:134:3::10]:48663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCCrR-0006rL-A6
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 20:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCCrM-0008AP-RZ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 20:05:20 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-9-mreitz@redhat.com>
	<20181015211722.GG31060@habkost.net>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <39b852b8-f570-a813-3e2b-2a20db94d3bb@redhat.com>
Date: Mon, 15 Oct 2018 20:05:02 -0400
MIME-Version: 1.0
In-Reply-To: <20181015211722.GG31060@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/9] iotests: Modify imports for Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>



On 10/15/18 5:17 PM, Eduardo Habkost wrote:
> On Mon, Oct 15, 2018 at 04:14:52PM +0200, Max Reitz wrote:
>> There are two imports that need to be modified when running the iotests
>> under Python 3: One is StringIO, which no longer exists; instead, the
>> StringIO class comes from the io module, so import it from there.  The
>> other is the ConfigParser, which has just been renamed to configparser.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/iotests.py            | 8 ++++++--
>>  tests/qemu-iotests/nbd-fault-injector.py | 7 +++++--
>>  2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
>> index 7ca94e9278..a64ea90fb4 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -683,13 +683,17 @@ def main(supported_fmts=[], supported_oses=['linux'], supported_cache_modes=[],
>>  
>>      # We need to filter out the time taken from the output so that qemu-iotest
>>      # can reliably diff the results against master output.
>> -    import StringIO
>> +    if sys.version_info.major >= 3:
>> +        from io import StringIO
>> +    else:
>> +        from StringIO import StringIO
> 
> Considering that io.StringIO exists on Python 2.7, a comment
> explaining why exactly it doesn't work would be nice.
> 

Another possibility, that I find self explanatory:

import io

if sys.version_info.major >= 3:
   output = io.StringIO()
else:
   output = io.BytesIO()

- Cleber.

> But this shouldn't block this workaround, so:
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> 
>> +
>>      if debug:
>>          output = sys.stdout
>>          verbosity = 2
>>          sys.argv.remove('-d')
>>      else:
>> -        output = StringIO.StringIO()
>> +        output = StringIO()
>>  
>>      logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
>>  
>> diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/nbd-fault-injector.py
>> index d45e2e0a6a..6b2d659dee 100755
>> --- a/tests/qemu-iotests/nbd-fault-injector.py
>> +++ b/tests/qemu-iotests/nbd-fault-injector.py
>> @@ -48,7 +48,10 @@ import sys
>>  import socket
>>  import struct
>>  import collections
>> -import ConfigParser
>> +if sys.version_info.major >= 3:
>> +    import configparser
>> +else:
>> +    import ConfigParser as configparser
>>  
>>  FAKE_DISK_SIZE = 8 * 1024 * 1024 * 1024 # 8 GB
>>  
>> @@ -225,7 +228,7 @@ def parse_config(config):
>>      return rules
>>  
>>  def load_rules(filename):
>> -    config = ConfigParser.RawConfigParser()
>> +    config = configparser.RawConfigParser()
>>      with open(filename, 'rt') as f:
>>          config.readfp(f, filename)
>>      return parse_config(config)
>> -- 
>> 2.17.1
>>
> 
