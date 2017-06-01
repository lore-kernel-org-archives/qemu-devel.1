Received: from eggs.gnu.org ([2001:4830:134:3::10]:57024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dGQXu-0004H0-DI
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dGQXt-0005UE-KR
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:53:50 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:34797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1dGQXt-0005O3-D1
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:53:49 -0400
Received: by mail-oi0-x22c.google.com with SMTP id o65so29811054oif.1
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 06:53:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <14af6adf-9076-1368-75bb-8001ed667150@gmail.com>
References: <20170526023213.18741-1-haozhong.zhang@intel.com>
	<14af6adf-9076-1368-75bb-8001ed667150@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 1 Jun 2017 06:53:45 -0700
Message-ID: <CAPcyv4jKoc00Oe7+NYngHc96Cahn3LF01ZdwHxVb_amq3p6UGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RESEND PATCH 1/2] nvdimm: warn if the backend is
 not a DAX device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

[ adding linux-fsdevel ]

On Thu, Jun 1, 2017 at 5:00 AM, Xiao Guangrong <guangrong.xiao@gmail.com> w=
rote:
>
>
> On 05/26/2017 10:32 AM, Haozhong Zhang wrote:
>
>> +static void nvdimm_check_dax(HostMemoryBackend *hostmem)
>> +{
>> +    char *mem_path =3D
>> +        object_property_get_str(OBJECT(hostmem), "mem-path", NULL);
>> +    char *dev_name =3D NULL, *sysfs_path =3D NULL;
>> +    bool is_dax =3D false;
>> +
>> +    if (!mem_path) {
>> +        goto out;
>> +    }
>> +
>> +    if (!g_str_has_prefix(mem_path, "/dev/dax")) {
>> +        goto out;
>> +    }
>> +
>> +    dev_name =3D mem_path + strlen("/dev/");
>> +    sysfs_path =3D g_strdup_printf("/sys/class/dax/%s", dev_name);
>> +    if (access(sysfs_path, F_OK)) {
>> +        goto out;
>> +    }
>> +
>> +    is_dax =3D true;
>> +
>
>
> So only dax raw disk has write-persistence guaranty=EF=BC=8C a pre-alloca=
ted
> file which locates on a DAX-enabled filesystem can not?

Correct, it is not guaranteed by any existing filesystem. It may work
by accident today on ext4 with a pre-allocated file, but a filesystem
is otherwise permitted to drop any writes that have not been synced.
Until we get an explicit MMAP_SYNC or METADATA_IMMUTABLE feature into
a filesystem the only interface that we can use to reliably pass
persistent memory through to a guest is device-dax.
