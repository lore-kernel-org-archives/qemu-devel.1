Received: from eggs.gnu.org ([2001:4830:134:3::10]:53515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAyhD-0006kM-Ae
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAyh8-00019A-Ay
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:13:27 -0400
References: <1524470305-26484-1-git-send-email-thuth@redhat.com>
	<1524470305-26484-3-git-send-email-thuth@redhat.com>
	<13a57e92-10ff-d89c-907b-3e927f6a9f3d@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e7a8083e-aeda-ef03-a431-77eb23e9e561@redhat.com>
Date: Tue, 24 Apr 2018 16:13:19 +0200
MIME-Version: 1.0
In-Reply-To: <13a57e92-10ff-d89c-907b-3e927f6a9f3d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/4] pc-bios/s390-ccw/net: Add support
 for pxelinux-style config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

On 24.04.2018 15:41, Viktor VM Mihajlovski wrote:
> On 23.04.2018 09:58, Thomas Huth wrote:
> [...]
>> +
>> +static int net_try_pxelinux_cfgs(filename_ip_t *fn_ip)
>> +{
>> +    int rc, idx;
>> +    char basedir[256];
>> +    int has_basedir;
>> +
>> +    cfgbuf[sizeof(cfgbuf) - 1] =3D 0;   /* Make sure that it is NUL-t=
erminated */
>> +
>> +    /* Did we get a usable base directory via DHCP? */
>> +    idx =3D strlen((char *)fn_ip->filename);
>> +    if (idx > 0 && idx < sizeof(basedir) - 40 &&
>> +        fn_ip->filename[idx - 1] =3D=3D '/') {
>> +        has_basedir =3D true;
>> +        strcpy(basedir, (char *)fn_ip->filename);
>> +    } else {
>> +        has_basedir =3D false;
>> +        strcpy(basedir, "pxelinux.cfg/");
>> +    }
>> +
>> +    printf("Trying pxelinux.cfg files...\n");
>> +
>> +    /* Look for config file with MAC address in its name */
>> +    sprintf((char *)fn_ip->filename, "%s%02x-%02x-%02x-%02x-%02x-%02x=
",
>> +            basedir, mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
> Just noticed that the filename has to be <basedir>/pxelinux.cfg/01-<mac=
>
> per [1].

Ok. I just also had a closer look at the URL that you've mentioned on
IRC (http://jk.ozlabs.org/blog/post/158/netbooting-petitboot/), and
noticed that there is even an additional DHCP option (210) for
specifying the prefix path ... so I'll try to rework my patches according=
ly.

 Thomas
