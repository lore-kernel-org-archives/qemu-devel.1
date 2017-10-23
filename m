Received: from eggs.gnu.org ([2001:4830:134:3::10]:48947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ahino@redhat.com>) id 1e6c0E-0001gz-Rb
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ahino@redhat.com>) id 1e6c0A-0000DN-Kg
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:38:46 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:52791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ahino@redhat.com>) id 1e6c0A-0000Cd-FO
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:38:42 -0400
Received: by mail-qt0-f179.google.com with SMTP id 31so25846500qtz.9
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 05:38:41 -0700 (PDT)
MIME-Version: 1.0
From: Ala Hino <ahino@redhat.com>
Date: Mon, 23 Oct 2017 15:38:40 +0300
Message-ID: <CAPuOgO3vuhZ8Dgk5GZrDFCrCV-a-1-Jq+eERma_vysh1PQohSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Question regarding qemuimg check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>

Hi,

I have a question regarding qemuimg check. We use qemuimg check in order to
get the offset of image. we need the offset to reduce the size of the image
to optimal.

In BZ 1502488 <https://bugzilla.redhat.com/1502488>, we are encountering a
use case where a leaked cluster error when executing qemuimg check. The
root cause of that exception is killing qemu-kvm process during writing to
a VM. In this case, executing qemuimg check ends with getting the leaked
cluster error. Below is the error:

2017-10-16 10:09:32,950+0530 DEBUG (tasks/0) [root] /usr/bin/taskset
--cpu-list 0-3 /usr/bin/qemu-img check --output json -f qcow2
/rhev/data-center/mnt/blockSD/8257cf14-d88d-4e4e-998c-9f8976dac2a2/images/7455de38-1df1-4acd-b07c-9dc2138aafb3/be4a4d85-d7e6-4725-b7f5-90c9d935c336
(cwd None) (commands:69)
2017-10-16 10:09:33,576+0530 ERROR (tasks/0)
[storage.TaskManager.Task]
(Task='59404af6-b400-4e08-9691-9a64cdf00374') Unexpected error
(task:872)
Traceback (most recent call last):
  File "/usr/share/vdsm/storage/task.py", line 879, in _run
    return fn(*args, **kargs)
  File "/usr/share/vdsm/storage/task.py", line 333, in run
    return self.cmd(*self.argslist, **self.argsdict)
  File "/usr/lib/python2.7/site-packages/vdsm/storage/securable.py",
line 79, in wrapper
    return method(self, *args, **kwargs)
  File "/usr/share/vdsm/storage/sp.py", line 1892, in finalizeMerge
    merge.finalize(subchainInfo)
  File "/usr/share/vdsm/storage/merge.py", line 271, in finalize
    optimal_size = subchain.base_vol.optimal_size()
  File "/usr/share/vdsm/storage/blockVolume.py", line 440, in optimal_size
    check = qemuimg.check(self.getVolumePath(), qemuimg.FORMAT.QCOW2)
  File "/usr/lib/python2.7/site-packages/vdsm/qemuimg.py", line 156, in check
    out = _run_cmd(cmd)
  File "/usr/lib/python2.7/site-packages/vdsm/qemuimg.py", line 416, in _run_cmd
    raise QImgError(cmd, rc, out, err)
QImgError: cmd=['/usr/bin/qemu-img', 'check', '--output', 'json',
'-f', 'qcow2', '/rhev/data-center/mnt/blockSD/8257cf14-d88d-4e4e-998c-9f8976dac2a2/images/7455de38-1df1-4acd-b07c-9dc2138aafb3/be4a4d85-d7e6-4725-b7f5-90c9d935c336'],
ecode=3, stdout={
QImgError: cmd=['/usr/bin/qemu-img', 'check', '--output', 'json',
'-f', 'qcow2', '/rhev/data-center/mnt/blockSD/8257cf14-d88d-4e4e-998c-9f8976dac2a2/images/7455de38-1df1-4acd-b07c-9dc2138aafb3/be4a4d85-d7e6-4725-b7f5-90c9d935c336'],
ecode=3, stdout={
    "image-end-offset": 7188578304,
    "total-clusters": 180224,
    "check-errors": 0,
    "leaks": 200,
    "leaks-fixed": 0,
    "allocated-clusters": 109461,
    "filename":
"/rhev/data-center/mnt/blockSD/8257cf14-d88d-4e4e-998c-9f8976dac2a2/images/7455de38-1df1-4acd-b07c-9dc2138aafb3/be4a4d85-d7e6-4725-b7f5-90c9d935c336",
    "format": "qcow2",
    "fragmented-clusters": 16741
}
, stderr=Leaked cluster 109202 refcount=1 reference=0


Based on the error info, "This means waste of disk space, but no harm to
data", is it OK to handle the error and continue in the flow as usual?

When hitting this behavior, the return code is 3. Are there other use
cases, in addition to cluster leaks, where 3 is returned as the error code?
Meaning, can we rely on that return code to determine that it is a leaked
cluster failure?

If we would like to ignore the cluster leaks, is there a way to call
qemuimg check (with some parameter maybe ?) that will not raise the error?

Finally, are we doing the right thing to get the image offset in order to
reduce its size to optimal?

(If you wonder why we need to reduce the image size, this is because during
snapshot merge, we extend the image size to accumulate the data of the top
and the base images.)
