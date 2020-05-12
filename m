Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F278C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9BF0206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NEK0Hxzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BF0206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYTo6-00017c-5C
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYTmd-0008PC-L7
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:13:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYTmU-0001np-80
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:13:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CC34vq144503;
 Tue, 12 May 2020 12:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=H8Emk3F5SBqHJ4PaGMjtA7gWQ0B/fuu1aLhruylFz9o=;
 b=NEK0HxzjT/3rbrA57IbsitrjhiHYsSQVpuJs1yAwtBV1IPmwpSfMdMTWeLS168MEhYTC
 BcD0S5DRfjv3fnsB0VHWNoTCTcd3oLHvr1FMl+CobsA9a5YCK3fg05OmiDdwldb3sHkX
 qfrLTDcTrDPVrlf9nFhjMYnmzWBw/zSey2Vqjly67+b7Td8pVYZRhpQUfHtviwU74/qg
 U02QR3uycweHcKwZT4GmMuozXTYXYNV1oro0djk3iYV1E0XiuzMBYIpUg5yIV6qJJ+DD
 /y+LjLo+GKLAe2y/1vPOQmLf1lMU5HJC8LxMFUFLLsj994OfdaJtQD8ghlTMQcoWcUWk ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 30x3mbthye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 May 2020 12:12:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CC8WID164520;
 Tue, 12 May 2020 12:12:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 30xbgjcpc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 12:12:54 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04CCCpKh020277;
 Tue, 12 May 2020 12:12:51 GMT
Received: from dhcp-10-39-202-98.vpn.oracle.com (/10.39.202.98)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 May 2020 05:12:51 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH RESEND v6 14/36] multi-process: setup a machine object for
 remote device process
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200512104314.GE300009@stefanha-x1.localdomain>
Date: Tue, 12 May 2020 08:12:48 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <91103CA1-3913-4E1D-94B6-D167F72A2116@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <6b44b86adfae6324f4dd62a24c1d84961627fca1.1587614626.git.elena.ufimtseva@oracle.com>
 <20200512104314.GE300009@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=3 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=3 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120091
Received-SPF: pass client-ip=156.151.31.85; envelope-from=jag.raman@oracle.com;
 helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 08:09:29
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 swapnil.ingle@nutanix.com, John G Johnson <john.g.johnson@oracle.com>,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On May 12, 2020, at 6:43 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Wed, Apr 22, 2020 at 09:13:49PM -0700, elena.ufimtseva@oracle.com =
wrote:
>> From: Jagannathan Raman <jag.raman@oracle.com>
>>=20
>> remote-machine object sets up various subsystems of the remote device
>> process. Instantiate PCI host bridge object and initialize RAM, IO &
>> PCI memory regions.
>>=20
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> ---
>> MAINTAINERS                   |  2 +
>> Makefile.objs                 |  1 +
>> exec.c                        |  3 +-
>> include/exec/address-spaces.h |  2 +
>> include/remote/machine.h      | 30 +++++++++++++
>> remote/Makefile.objs          |  2 +
>> remote/machine.c              | 84 =
+++++++++++++++++++++++++++++++++++
>> remote/remote-main.c          |  7 +++
>=20
> Now that the separate remote emulation program is going away I think =
it
> makes sense to move the PCIe host and machine type into hw/:
>=20
>  hw/pci-host/remote.c <-- PCIe host
>  hw/i386/remote.c     <-- machine type (could be moved again later if
>                           other architectures are supported)

OK, got it.

>=20
>> diff --git a/exec.c b/exec.c
>> index d0ac9545f4..5b1e414099 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -161,7 +161,6 @@ typedef struct subpage_t {
>> #define PHYS_SECTION_UNASSIGNED 0
>>=20
>> static void io_mem_init(void);
>> -static void memory_map_init(void);
>=20
> The memory_map_init() change is unnecessary once a softmmu target is
> used since it will be called from cpu_exec_init_all().

OK.

>=20
>> +static void remote_machine_init(Object *obj)
>> +{
>> +    RemMachineState *s =3D REMOTE_MACHINE(obj);
>> +    RemPCIHost *rem_host;
>> +    MemoryRegion *system_memory, *system_io, *pci_memory;
>> +
>> +    Error *error_abort =3D NULL;
>> +
>> +    object_property_add_child(object_get_root(), "machine", obj, =
&error_abort);
>> +    if (error_abort) {
>=20
> error_abort aborts the program so handling it is not necessary.

OK, thanks!

>=20
>> +        error_report_err(error_abort);
>> +    }
>> +
>> +    memory_map_init();
>> +
>> +    system_memory =3D get_system_memory();
>> +    system_io =3D get_system_io();
>> +
>> +    pci_memory =3D g_new(MemoryRegion, 1);
>> +    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
>> +
>> +    rem_host =3D REMOTE_HOST_DEVICE(qdev_create(NULL, =
TYPE_REMOTE_HOST_DEVICE));
>> +
>> +    rem_host->mr_pci_mem =3D pci_memory;
>> +    rem_host->mr_sys_mem =3D system_memory;
>> +    rem_host->mr_sys_io =3D system_io;
>> +
>> +    s->host =3D rem_host;
>> +
>> +    object_property_add_child(OBJECT(s), "remote-device", =
OBJECT(rem_host),
>> +                              &error_abort);
>> +    if (error_abort) {
>=20
> error_abort aborts the program so handling it is not necessary.
>=20
>> +        error_report_err(error_abort);
>> +        return;
>> +    }
>> +
>> +    qemu_mutex_lock_iothread();
>=20
> This will be executed with the iothread lock held. There is no need to
> acquire it.

Yes, this wouldn=E2=80=99t be necessary from QEMU=E2=80=99s main loop.

Thanks!
--
Jag

>=20
>> +    memory_region_add_subregion_overlap(system_memory, 0x0, =
pci_memory, -1);
>> +    qemu_mutex_unlock_iothread();
>> +
>> +    qdev_init_nofail(DEVICE(rem_host));
>> +}


