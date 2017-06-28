Received: from eggs.gnu.org ([2001:4830:134:3::10]:36126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dQEwD-0007Oo-VM
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dQEwA-0006pt-Qe
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:31:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dQEwA-0006pg-K8
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:31:26 -0400
Date: Wed, 28 Jun 2017 17:31:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170628173119.6e9d832d@nial.brq.redhat.com>
In-Reply-To: <a5dba6ac-2c13-0a69-4cdb-504fe01b5866@redhat.com>
References: <20170621113600.GA3928@thinpad.lan.raisama.net>
	<8135ff45-0341-1fd4-ada9-4527c6b61e5a@ilande.co.uk>
	<20170621132317.GD3928@thinpad.lan.raisama.net>
	<7b431646-019e-dce2-6345-bdbaba7ce821@ilande.co.uk>
	<20170623115051.GE20956@localhost.localdomain>
	<a5f86c32-c89b-98ff-dbdb-7457a2074f1a@redhat.com>
	<20170623161043.GA10204@localhost.localdomain>
	<60e57713-c9ce-2bf4-db6e-23686fcc955b@redhat.com>
	<20170623185000.GA3038@localhost.localdomain>
	<120b9dac-982b-1e3b-662f-e60110b3d730@ilande.co.uk>
	<20170627004930.GI12152@localhost.localdomain>
	<f6a0bc2b-bf91-4c49-aa41-7816da70252c@ilande.co.uk>
	<20170628161247.168c4acb@nial.brq.redhat.com>
	<a5dba6ac-2c13-0a69-4cdb-504fe01b5866@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv6 3/5] fw_cfg: move assert() and linking of
 fw_cfg device to the machine into instance_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com

On Wed, 28 Jun 2017 16:21:40 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 06/28/17 16:12, Igor Mammedov wrote:
> > On Wed, 28 Jun 2017 08:09:35 +0100
> > Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:  
> 
> >> 1) Alter fw_cfg_find() to use object_resolve_path_type("", TYPE_FW_CFG,
> >> NULL)  
> > I'd make use of the 3rd argument &ambiguous and assert on it  
> 
> I vaguely recall playing with "ambiguous" in find_vmgenid_dev(), but it
> didn't work as I expected (or, it wasn't necessary to use). Not sure
> about the details, I only remember that, when calling
> object_resolve_path_type() like above, from within a realize function,
> the object under realization is already considered existent, so if we're
> realizing the second (or later) instance of the class,
> object_resolve_path_type() will return NULL (regardless of "ambiguous").
> If we're realizing the very first instance, then
> object_resolve_path_type() will return non-NULL.
> 
> I don't mind "ambiguous" if it can be made work fine, just thought that
> I'd add this tidbit.


looking at object_resolve_partial_path()

        if (ambiguous && *ambiguous) {                                           
            return NULL;                                                         
        }

might make object_resolve_partial_path() return non NULL if ambiguous is NULL


object_resolve_partial_path(,,, NULL)
p0 - p00 - fw0
    |    |
    |      fw1
    |
     fw2

p00 returns NULL &&  only fw2 is found without knowing at all about p00 failure


> 
> Thanks,
> Laszlo
