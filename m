Received: from eggs.gnu.org ([2001:4830:134:3::10]:41224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gSLhX-0001uA-Oq
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gSLhU-0001SJ-F5
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:45:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gSLhU-0001Rr-6e
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:45:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57668132686
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 12:45:47 +0000 (UTC)
References: <20181121183900.10364-1-wainersm@redhat.com>
	<20181126125807.GA14485@localhost.localdomain>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <cd57c38b-13c2-68b3-b924-b87ce65628d2@redhat.com>
Date: Thu, 29 Nov 2018 10:45:33 -0200
MIME-Version: 1.0
In-Reply-To: <20181126125807.GA14485@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] scripts/qemu.py: allow to launch the VM
 without a monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Caio Carrara <ccarrara@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, crosa@redhat.com, philmd@redhat.com


On 11/26/2018 10:58 AM, Caio Carrara wrote:
> On Wed, Nov 21, 2018 at 01:39:00PM -0500, Wainer dos Santos Moschetta w=
rote:
>> QEMUMachine launches the VM with a monitor enabled, afterwards
>> a qmp connection is attempted on _post_launch(). In case
>> the QEMU process exits with an error, qmp.accept() reaches
>> timeout and raises an exception.
>>
>> But sometimes you don't need that monitor. As an example,
>> when a test launches the VM expects its immediate crash,
>> and only intend to check the process's return code. In this
>> case the fact that launch() tries to establish the qmp
>> connection (ending up in an exception) is troublesome.
>>
>> So this patch adds the set_qmp_monitor() that allow to
>> launch the VM without creating the monitor machinery. The
>> method can be used to re-enable the monitor eventually.
>>
>> Tested this change with the following Avocado test:
>>
>> from avocado_qemu import Test
>>
>> class DisableQmp(Test):
> I think it would be fine to have this test added as a real test instead
> of just let this here on commit message. Or at least we should have a
> real use case that uses this new feature.

Currently we don't have a proper place to put tests for scripts/qemu.py,=20
but [1] opens the opportunity to create a self-test structure for the=20
avocado_qemu API. For now I suggest to keep that (self)test just on the=20
commit message.

The feature I am introducing on this patch could have used on [2], so=20
that it wouldn't need to call the qemu binary directly. I'm not changing=20
that test on this patch because it was not merged into master yet, so I=20
don't know exactly how it could be done.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg576435.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg572744.html

>
>>      """
>>      :avocado: enable
>>      """
>>      def test(self):
>>          self.vm.add_args('--foobar')
>>          self.vm.set_qmp_monitor(disabled=3DTrue)
>>          self.vm.launch()
>>          self.vm.wait()
>>          self.assertEqual(self.vm.exitcode(), 1)
>>          self.vm.shutdown()
>>
>>          self.vm.set_qmp_monitor(disabled=3DFalse)
>>          self.vm._args.remove('--foobar') # Hack
>>          self.vm.launch()
>>          res =3D self.vm.command('human-monitor-command',
>>                                command_line=3D'info version')
>>          self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>> Changes in v2:
>>    * Major refactor: replaced disable_qmp() with set_qmp_monitor()
>>      that allow to disable the qmp monitor likewise, but also one can
>>      re-enable it (set_qmp_monitor(disabled=3DFalse)).
>>    * The logic to enabled/disable the monitor is back to
>>      _base_args(). [ccarrara, ehabkost]
>> ---
>>   scripts/qemu.py | 72 ++++++++++++++++++++++++++++++++---------------=
--
>>   1 file changed, 48 insertions(+), 24 deletions(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 6e3b0e6771..54fe0e65d2 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -115,6 +115,7 @@ class QEMUMachine(object):
>>           self._events =3D []
>>           self._iolog =3D None
>>           self._socket_scm_helper =3D socket_scm_helper
>> +        self._with_qmp =3D True   # Enable QMP monitor by default.
>>           self._qmp =3D None
>>           self._qemu_full_args =3D None
>>           self._test_dir =3D test_dir
>> @@ -229,15 +230,7 @@ class QEMUMachine(object):
>>                   self._iolog =3D iolog.read()
>>  =20
>>       def _base_args(self):
>> -        if isinstance(self._monitor_address, tuple):
>> -            moncdev =3D "socket,id=3Dmon,host=3D%s,port=3D%s" % (
>> -                self._monitor_address[0],
>> -                self._monitor_address[1])
>> -        else:
>> -            moncdev =3D 'socket,id=3Dmon,path=3D%s' % self._vm_monito=
r
>> -        args =3D ['-chardev', moncdev,
>> -                '-mon', 'chardev=3Dmon,mode=3Dcontrol',
>> -                '-display', 'none', '-vga', 'none']
>> +        args =3D ['-display', 'none', '-vga', 'none']
>>           if self._machine is not None:
>>               args.extend(['-machine', self._machine])
>>           if self._console_device_type is not None:
>> @@ -247,23 +240,33 @@ class QEMUMachine(object):
>>                          self._console_address)
>>               device =3D '%s,chardev=3Dconsole' % self._console_device=
_type
>>               args.extend(['-chardev', chardev, '-device', device])
>> +        if self._with_qmp:
>> +            if isinstance(self._monitor_address, tuple):
>> +                moncdev =3D "socket,id=3Dmon,host=3D%s,port=3D%s" % (
>> +                    self._monitor_address[0],
>> +                    self._monitor_address[1])
>> +            else:
>> +                moncdev =3D 'socket,id=3Dmon,path=3D%s' % self._vm_mo=
nitor
>> +            args.extend(['-chardev', moncdev, '-mon', 'chardev=3Dmon,=
mode=3Dcontrol'])
>> +
>>           return args
>>  =20
>>       def _pre_launch(self):
>>           self._temp_dir =3D tempfile.mkdtemp(dir=3Dself._test_dir)
>> -        if self._monitor_address is not None:
>> -            self._vm_monitor =3D self._monitor_address
>> -        else:
>> -            self._vm_monitor =3D os.path.join(self._temp_dir,
>> -                                            self._name + "-monitor.so=
ck")
>>           self._qemu_log_path =3D os.path.join(self._temp_dir, self._n=
ame + ".log")
>>           self._qemu_log_file =3D open(self._qemu_log_path, 'wb')
>>  =20
>> -        self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._vm_monitor,
>> -                                                server=3DTrue)
>> -
>> +        if self._with_qmp:
>> +            if self._monitor_address is not None:
>> +                self._vm_monitor =3D self._monitor_address
>> +            else:
>> +                self._vm_monitor =3D os.path.join(self._temp_dir,
>> +                                            self._name + "-monitor.so=
ck")
>> +            self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._vm_monito=
r,
>> +                                                    server=3DTrue)
>>       def _post_launch(self):
>> -        self._qmp.accept()
>> +        if self._qmp:
>> +            self._qmp.accept()
>>  =20
>>       def _post_shutdown(self):
>>           if self._qemu_log_file is not None:
>> @@ -325,7 +328,8 @@ class QEMUMachine(object):
>>           Wait for the VM to power off
>>           """
>>           self._popen.wait()
>> -        self._qmp.close()
>> +        if self._qmp:
> Isn't the self._with_qmp attribute that should be used here? I think
> it's important to standardize the checks for qmp availability in
> `with_qmp` attribute and use the `qmp` only for qmp access itself. Ther=
e
> are other places that uses qmp to this kind of check too.

Checking self._qmp has same result as self._with_qmp given that=20
self._qmp object is only created with qmp enabled. But I agree with you=20
that for the sake of readability it would be better to check with=20
self._with_qmp.=C2=A0 I will send a v2.

>
>> +            self._qmp.close()
>>           self._load_io_log()
>>           self._post_shutdown()
>>  =20
>> @@ -334,11 +338,14 @@ class QEMUMachine(object):
>>           Terminate the VM and clean up
>>           """
>>           if self.is_running():
>> -            try:
>> -                self._qmp.cmd('quit')
>> -                self._qmp.close()
>> -            except:
>> -                self._popen.kill()
>> +            if self._qmp:
>> +                try:
>> +                    self._qmp.cmd('quit')
>> +                    self._qmp.close()
>> +                except:
>> +                    self._popen.kill()
>> +            else:
>> +                self._popen.terminate()
>>               self._popen.wait()
>>  =20
>>           self._load_io_log()
>> @@ -355,6 +362,23 @@ class QEMUMachine(object):
>>  =20
>>           self._launched =3D False
>>  =20
>> +    def set_qmp_monitor(self, disabled=3DFalse, monitor_address=3DNon=
e):
> Where is this new method being used?

It's not used yet, but we will need this on some type of tests (e.g.=20
launch the VM and expect an immediate crash) very often. I mentioned=20
above one test that I could have used it already.

> .
>
>> +        """
>> +        Set the QMP monitor.
>> +
>> +        @param disabled: if True, qmp monitor options will be removed=
 from the
>> +                         base arguments of the resulting QEMU command=
 line.
>> +        @param monitor_address: address for the QMP monitor.
>> +        @note: call this function before launch().
>> +        """
>> +        if disabled:
>> +            self._with_qmp =3D False
>> +            self._qmp =3D None
>> +        else:
>> +            self._with_qmp =3D True
>> +            if monitor_address:
>> +                self._monitor_address =3D monitor_address
>> +
>>       def qmp(self, cmd, conv_keys=3DTrue, **args):
>>           """
>>           Invoke a QMP command and return the response dict
>> --=20
>> 2.19.1
>>
> It would be nice see less scattered checks for qmp availability along
> the code.

I agree. It will need a major refactor on scripts/qemu.py though. I want=20
to keep this patch=C2=A0 as simple as possible so that it can be used on =
the=20
ongoing tests implementation.

Thanks for the review!

- Wainer


>  =20
>
> Thanks.
