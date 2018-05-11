Received: from eggs.gnu.org ([2001:4830:134:3::10]:48753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fHA7S-0002vp-SG
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fHA7N-00068O-SJ
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:38:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45396 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fHA7N-00068A-NA
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:38:01 -0400
References: <20180420181951.7252-1-ehabkost@redhat.com>
	<20180420181951.7252-2-ehabkost@redhat.com>
	<20180420195625.GF29865@localhost.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <f704201e-1332-2ba6-a530-099da1cd72b2@redhat.com>
Date: Fri, 11 May 2018 11:37:58 -0400
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Fam Zheng <famz@redhat.com>



On 04/20/2018 03:56 PM, Eduardo Habkost wrote:
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
>>  
>>      def __init__(self, binary, args=None, wrapper=None, name=None,
>>                   test_dir="/var/tmp", monitor_address=None,
>> -                 socket_scm_helper=None):
>> +                 socket_scm_helper=None, arch=None):
>>          '''
>>          Initialize a QEMUMachine
>>  
>> @@ -91,6 +91,10 @@ class QEMUMachine(object):
>>          self._test_dir = test_dir
>>          self._temp_dir = None
>>          self._launched = False
>> +        if arch is None:
>> +            arch = binary.split('-')[-1]
> 
> This is not good.  We don't want a test case to break only
> because we renamed a QEMU binary (e.g. RHEL uses
> /usr/libexec/qemu-kvm, and I can imagine people using qemu.py to
> write test scripts for it).
> 
> 

Agreed.  This is a simple but fragile way of getting the arch for a
binary.  How about getting this from the QEMU binary itself using a
"query-target" QMP command?  This would, for the sake of simplicity,
require a separate QEMU execution, though.

But an even more important usability issue is this "automagic" behavior.
 While it may be useful for higher level APIs, such as
"avocado_qemu.Test", IMO it should be explicitly enabled, and current
behavior should be preserved.  Only by doing something like

   m = QEMUMachine("/path/to/binary", automatic_devices=True)

Devices based on the architecture (and machine type?) would be added by
default.  Naming is hard, so suggestions for the option name are
appreciated.

>> +        self._arch = arch
>> +        self._console_address = None
>>  
>>          # just in case logging wasn't configured by the main script:
>>          logging.basicConfig()
>> @@ -179,6 +183,39 @@ class QEMUMachine(object):
>>                  '-mon', 'chardev=mon,mode=control',
>>                  '-display', 'none', '-vga', 'none']
>>  
>> +    def _create_console(self, console_address):
>> +        for item in self._args:
>> +            for option in ['isa-serial', 'spapr-vty', 'sclpconsole']:
>> +                if option in item:
>> +                    return []
> 
> This is very fragile.  What's the goal of this chunk of code?
> 
> 

Agreed again.

>> +
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

In my executions with both ppc and ppc64, it failed with ppc not
supporting spapr-vty.  I'd go with exact arch matches, and not
approximations.

>> +        elif 's390x' in self._arch:
>> +            device = device.format(dev_type='sclpconsole')

And this is fragile because s390x won't allow for more than one operator
console.  Exact qemu-system-s390x output is:

   Multiple VT220 operator consoles are not supported
   SCLP event initialization failed.

> 
> Why do we need this? Why isn't -serial enough?
> 
> 

No, some arches need special handling, but this is indeed too fragile.

>> +        else:
>> +            return []
>> +
>> +        return ['-chardev', chardev,
>> +                '-device', device]
>> +
>>      def _pre_launch(self):
>>          self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
>>          if self._monitor_address is not None:
>> @@ -206,7 +243,7 @@ class QEMUMachine(object):
>>              shutil.rmtree(self._temp_dir)
>>              self._temp_dir = None
>>  
>> -    def launch(self):
>> +    def launch(self, console_address=None):

Querying the console address should be available to users, but I don't
see the reason for making it a launch() argument.

>>          """
>>          Launch the VM and make sure we cleanup and expose the
>>          command line/output in case of exception
>> @@ -218,7 +255,7 @@ class QEMUMachine(object):
>>          self._iolog = None
>>          self._qemu_full_args = None
>>          try:
>> -            self._launch()
>> +            self._launch(console_address)
>>              self._launched = True
>>          except:
>>              self.shutdown()
>> @@ -230,12 +267,14 @@ class QEMUMachine(object):
>>                  LOG.debug('Output: %r', self._iolog)
>>              raise
>>  
>> -    def _launch(self):
>> +    def _launch(self, console_address):
>>          '''Launch the VM and establish a QMP connection'''
>>          devnull = open(os.path.devnull, 'rb')
>>          self._pre_launch()
>> +        bargs = self._base_args()
>> +        bargs.extend(self._create_console(console_address))
>>          self._qemu_full_args = (self._wrapper + [self._binary] +
>> -                                self._base_args() + self._args)
>> +                                bargs + self.args)


With the addition of "automagic" devices, I'd propose three internal
argument categories:

 1) base args (self._base_args()), which will always be necessary and
created by QEMUMachine.
 2) auto args, always empty if QEMUMachine() is not given
automatic_devices=True.
 3) user args (self._args)

- Cleber.

>>          self._popen = subprocess.Popen(self._qemu_full_args,
>>                                         stdin=devnull,
>>                                         stdout=self._qemu_log_file,
>> -- 
>> 2.14.3
>>
> 
