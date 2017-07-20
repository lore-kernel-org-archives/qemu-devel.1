Received: from eggs.gnu.org ([2001:4830:134:3::10]:56688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dYJ95-0004gj-RP
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dYJ92-0008As-Jp
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:38:07 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:55292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dYJ91-0008AA-J2
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:38:04 -0400
Date: Fri, 21 Jul 2017 03:07:56 +0530 (IST)
From: Ishani <chugh.ishani@research.iiit.ac.in>
Message-ID: <1958798295.293580.1500586676031.JavaMail.zimbra@research.iiit.ac.in>
In-Reply-To: <20170717143258.GQ7163@stefanha-x1.localdomain>
References: <1500151401-30863-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<20170717143258.GQ7163@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] RFC on Backup tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow <jsnow@redhat.com>

----- On Jul 17, 2017, at 8:02 PM, stefanha stefanha@redhat.com wrote:

> On Sun, Jul 16, 2017 at 02:13:21AM +0530, Ishani Chugh wrote:
>> +    def write_config(self):
>> +        """
>> +        Writes configuration to ini file.
>> +        """
>> +        with open(self.config_file, 'w') as config_file:
>> +            self.config.write(config_file)
> 
> Please update the config file atomically.  That means the file must be
> consistent at all points in time.  Things to consider:
> 
> 1. open(self.config_file, 'w') truncates the destination file.  If the
>   program crashes or is paused before self.config.write() then the
>   config file will appear empty (its contents are lost)!
> 
> 2. Data is written to the file at the end of the 'with' statement
>   (because that flushes the buffer and closes the file), but there is
>   no guarantee that data is safely stored on disk.  Please use
>   https://docs.python.org/3/library/os.html#os.fsync to prevent data
>   loss in case of power failure.
> 
> The usual pattern is:
> 1. Create a temporary file next to the file you wish to modify.  "Next
>   to" is important because if you create it on another file system
>   (like tmpfs) it may not be possible to atomically replace the old
>   file.
> 2. Write data
> 3. file.flush() + os.fsync() to safely store data in the new file
> 4. os.rename() to atomically replace the old file
> 
> For an example, see:
> https://stackoverflow.com/questions/2333872/atomic-writing-to-file-with-python

Thanks. I will update in next revision.

>> +
>> +    def get_socket_path(self, socket_path, tcp):
>> +        """
>> +        Return Socket address in form of string or tuple
> 
> Please rename this function get_socket_address().  The return value is
> an 'address', not a 'path'.

Will update in next revision.

>> +        """
>> +        if tcp is False:
> 
> PEP8 says:
> 
>  Don't compare boolean values to True or False using == .
> 
>  Yes:   if greeting:
>  No:    if greeting == True:
>  Worse: if greeting is True:
> 
> So this should be:
> 
>  if not tcp:
> 
Will update in next revision.
>> +            return os.path.abspath(socket_path)
>> +        return (socket_path.split(':')[0], int(socket_path.split(':')[1]))
> 
> The str.split(delim, maxsplit) argument can be used but feel free to
> keep your version if you prefer:
> 
>  return tuple(socket_path.split(':', 1))
>
 
Thanks for suggestion. It is a much cleaner method.

>> +
>> +    def __full_backup(self, guest_name):
>> +        """
>> +        Performs full backup of guest
>> +        """
>> +        if guest_name not in self.config.sections():
>> +            print ("Cannot find specified guest")
>> +            return
>> +        if self.is_guest_running(guest_name, self.config[guest_name]['qmp'],
>> +                                 self.config[guest_name]['tcp']) is False:
> 
> This is clearer if self.is_guest_running() looks up the necessary
> information in self.config[] itself:
> 
>  if not self.is_guest_running(guest_name):
>      ...
> 
> Since is_guest_running() is a method it has access to self.config[] and
> there's no need for every caller to fetch 'qmp'/'tcp'.

I agree. I am using the same method to check if a guest is running before adding
an entry to config file when user gives command to add guest. It is possible to 
first add entries in config file and then check if the guest is running and delete
the entry from config file if guest is found not running. 
 
>> +            return
>> +        connection = QEMUMonitorProtocol(
>> +                                         self.get_socket_path(
>> +                                             self.config[guest_name]['qmp'],
>> +                                             self.config[guest_name]['tcp']))
>> +        connection.connect()
>> +        cmd = {"execute": "transaction", "arguments": {"actions": []}}
>> +        for key in self.config[guest_name]:
>> +            if key.startswith("drive_"):
>> +                drive = key[key.index('_')+1:]
> 
> len('drive_') is a little clearer than key.index('_')+1.

Thanks. Will update in next revision.

>> +                target = self.config[guest_name][key]
>> +                sub_cmd = {"type": "drive-backup", "data": {"device": drive,
>> +                                                            "target": target,
>> +                                                            "sync": "full"}}
>> +                cmd['arguments']['actions'].append(sub_cmd)
>> +        print (connection.cmd_obj(cmd))
> 
> The non-RFC version of this patch should not print raw qmp.py objects.
> That's useful for debugging but not user-friendly.  Either there could
> be no output and a 0 exit code (indicating success), or there could be a
> message like:
> 
>  Starting full backup of drives:
>   * drive0
>   * drive1
>  Backup complete!

Thanks. Will update in next revision.

>> +
>> +    def __drive_add(self, drive_id, guest_name, target=None):
>> +        """
>> +        Adds drive for backup
>> +        """
>> +        if target is None:
>> +            target = os.path.abspath(drive_id) + ".img"
> 
> Not sure if this is really useful.  Many image files have a non-.img
> file extension like .qcow2.  Guessing the target filename is probably
> just confusing because the user experience will be inconsistent
> (sometimes it works, sometimes it doesn't, depending on the file
> extension and the current working directory).


Is it okay if I give the target image a name same as drive id without any
extension? 
 
>> +
>> +        if guest_name not in self.config.sections():
>> +            print ("Cannot find specified guest")
>> +            return
>> +
>> +        if "drive_"+drive_id in self.config[guest_name]:
>> +            print ("Drive already marked for backup")
>> +            return
>> +
>> +        if self.is_guest_running(guest_name, self.config[guest_name]['qmp'],
>> +                                 self.config[guest_name]['tcp']) is False:
>> +            return
> 
> Silently exiting is confusing behavior.  There should be an error
> message and the process should terminate with a failure exit code (1).
> 
> By the way, it may be best to avoid repetition by writing methods for
> these checks:
> 
>  def verify_guest_exists(self, guest_name):
>      if guest_name not in self.config.sections():
>          print('Cannot find specified guest', file=sys.stderr)
>          sys.exit(1)
> 
>  def verify_guest_running(self, guest_name):
>      if not self.is_guest_running(guest_name):
>          print('Unable to connect to guest (is the guest running?)', file=sys.stderr)
>          sys.exit(1)
> 
>  def a_command(self, guest_name):
>      self.verify_guest_exists(guest_name)
>      self.verify_guest_running(guest_name)

The intention was similar behind this. I will rewrite and send the revision.
 
>> +
>> +        connection = QEMUMonitorProtocol(
>> +                                         self.get_socket_path(
>> +                                             self.config[guest_name]['qmp'],
>> +                                             self.config[guest_name]['tcp']))
>> +        connection.connect()
>> +        cmd = {'execute': 'query-block'}
>> +        returned_json = connection.cmd_obj(cmd)
>> +        device_present = False
>> +        for device in returned_json['return']:
>> +            if device['device'] == drive_id:
>> +                device_present = True
>> +                break
>> +
>> +        if device_present is False:
>> +            print ("No such drive in guest")
>> +            return
>> +
>> +        drive_id = "drive_" + drive_id
>> +        for id in self.config[guest_name]:
>> +            if self.config[guest_name][id] == target:
>> +                print ("Please choose different target")
>> +                return
> 
> Please make it clear from the error message that this is a duplicate
> target.  "Please choose different target" doesn't explain why there is a
> problem and users would be confused.
> 
Thanks. Will update in next revision.

>> +        self.config.set(guest_name, drive_id, target)
>> +        self.write_config()
>> +        print("Successfully Added Drive")
>> +
>> +    def is_guest_running(self, guest_name, socket_path, tcp):
> 
> It is not necessary to distinguish between UNIX domain socket paths and
> TCP <host, port> pairs here or in the config file:
> 
>  >>> c.add_section('a')
>  >>> c.set('a', 'b', ('hello', 'world'))
>  >>> c.get('a', 'b')
>  ('hello', 'world')
>  >>> c.set('a', 'b', '/hello/world')
>  >>> c.get('a', 'b')
>  '/hello/world'
> 
> If you treat the value as an opaque address type it doesn't matter
> whether it's a TCP <host, port> pair or a UNIX domain socket path.  You
> can pass the return value of c.get() directly to the QEMUMonitorProtocol
> constructor:
> 
>  QEMUMonitorProtocol(self.config.get(guest_name, 'qmp'))
> 
> You still need to parse the address in 'qemu-backup guest add' though.
> 

Will update in next revision.

>> +        """
>> +        Checks whether specified guest is running or not
>> +        """
>> +        try:
>> +            connection = QEMUMonitorProtocol(
>> +                                             self.get_socket_path(
>> +                                                  socket_path, tcp))
>> +            connection.connect()
>> +        except socket_error:
>> +            if socket_error.errno != errno.ECONNREFUSED:
>> +                print ("Connection to guest refused")
> 
> What is the purpose of this if statement?
It should be removed. Will fix in next revision.

Thanks,
Ishani
