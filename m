Received: from eggs.gnu.org ([2001:4830:134:3::10]:33191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl6yD-0008EQ-Ed
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl6yA-0006Wf-4p
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:15:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dl6y9-0006VV-R9
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:15:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CDE820276
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 05:15:44 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <87ziapi2qe.fsf@dusky.pond.sub.org>
Date: Fri, 25 Aug 2017 07:15:40 +0200
In-Reply-To: <87ziapi2qe.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 24 Aug 2017 14:12:25 +0200")
Message-ID: <87o9r45itf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Structure / order of generated QAPI/QMP docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> We've split sub-schemas off qapi-schema.json to enable proper
> MAINTAINERS coverage, and also because the complete schema has become
> rather large.
>
> The reference documentation generated with qapi2texi.py is in textual
> schema order, with included sub-schemas inserted at the first include
> directive (subsequent include directives have no effect).
>
> Our sub-schemas start with a section title (except for
> qapi/introspect.json, but I'm fixing that).  In other words, we derive
> the structure of our reference documentation from the maintenance
> domains.  The resulting structure is servicable, but it could use some
> love.
>
> To see the structure, run "make txt", then
>
>     $ egrep '^[0-9]\.|^ --' -h docs/interop/qemu-qmp-ref.txt
>
> Output with my "[PATCH 0/3] qapi-schema: Generated doc structure fixes"
> applied appended for your convenience.

Updated output after my "[PATCH v2 00/16] qapi-schema: Reorganize along
maintenance boundaries" appended.

> Observations:
>
> * The section headings are generally sub-par.
>
> * We have several grab-bags of miscellanea, one at the beginning, one in
>   the middle, and one at the end:
>
>   1.3 QAPI common definitions

Cleaned up and retitled to "1.3 Common data types".

>   1.6 Other events

Gone.

>   1.10 QMP commands

Shrunk by half, still way too big.  Retitled to "1.18 Miscellanea".

>   This needs to be rethought.
>
>   An obvious first step is to factor out more sub-schemas along
>   maintenance domains.  I'll do that next.

Done.

The sub-schemas might be a way to crack the monolith.

Traditionally, we slice up generated QAPI into types, visits, commands,
events, introspection.  One .h and one .c per slice.  All but
qmp-introspect.h includes qapi-types.h.  qapi-types.h dwarfs the others
several times over:

    $ wc bld-x86/q[am]*h
       141    501   5492 bld-x86/qapi-event.h
      6484  12927 152131 bld-x86/qapi-types.h
      1172   6582  77873 bld-x86/qapi-visit.h
       326   2311  24734 bld-x86/qmp-commands.h
        18     57    364 bld-x86/qmp-introspect.h
      8141  22378 260594 total

A single header would probably compile not noticably slower.

The split between commands and events seems useless.

Can we slice off the sub-schemas?  Have qapi-types.h include
qapi-$subschema-types.h for each { 'include': '$subschema.json' }.
Recursively.  If this idea needs discussion rather than exploration in
code, it should go into its own thread.


1.1 Introduction
1.2 Stability Considerations
1.3 Common data types
 -- Enum: QapiErrorClass
 -- Enum: IoOperationType
 -- Enum: OnOffAuto
 -- Enum: OnOffSplit
 -- Object: String
 -- Alternate: StrOrNull
1.4 Socket data types
 -- Enum: NetworkAddressFamily
 -- Object: InetSocketAddressBase
 -- Object: InetSocketAddress
 -- Object: UnixSocketAddress
 -- Object: VsockSocketAddress
 -- Object: SocketAddressLegacy
 -- Enum: SocketAddressType
 -- Object: SocketAddress
1.5 VM run state
 -- Enum: RunState
 -- Object: StatusInfo
 -- Command: query-status
 -- Event: SHUTDOWN
 -- Event: POWERDOWN
 -- Event: RESET
 -- Event: STOP
 -- Event: RESUME
 -- Event: SUSPEND
 -- Event: SUSPEND_DISK
 -- Event: WAKEUP
 -- Event: WATCHDOG
 -- Enum: WatchdogExpirationAction
 -- Event: GUEST_PANICKED
 -- Enum: GuestPanicAction
 -- Enum: GuestPanicInformationType
 -- Object: GuestPanicInformation
 -- Object: GuestPanicInformationHyperV
1.6 Cryptography
 -- Enum: QCryptoTLSCredsEndpoint
 -- Enum: QCryptoSecretFormat
 -- Enum: QCryptoHashAlgorithm
 -- Enum: QCryptoCipherAlgorithm
 -- Enum: QCryptoCipherMode
 -- Enum: QCryptoIVGenAlgorithm
 -- Enum: QCryptoBlockFormat
 -- Object: QCryptoBlockOptionsBase
 -- Object: QCryptoBlockOptionsQCow
 -- Object: QCryptoBlockOptionsLUKS
 -- Object: QCryptoBlockCreateOptionsLUKS
 -- Object: QCryptoBlockOpenOptions
 -- Object: QCryptoBlockCreateOptions
 -- Object: QCryptoBlockInfoBase
 -- Object: QCryptoBlockInfoLUKSSlot
 -- Object: QCryptoBlockInfoLUKS
 -- Object: QCryptoBlockInfoQCow
 -- Object: QCryptoBlockInfo
1.7 Block devices
1.7.1 Block core (VM unrelated)
 -- Object: SnapshotInfo
 -- Object: ImageInfoSpecificQCow2EncryptionBase
 -- Object: ImageInfoSpecificQCow2Encryption
 -- Object: ImageInfoSpecificQCow2
 -- Object: ImageInfoSpecificVmdk
 -- Object: ImageInfoSpecific
 -- Object: ImageInfo
 -- Object: ImageCheck
 -- Object: MapEntry
 -- Object: BlockdevCacheInfo
 -- Object: BlockDeviceInfo
 -- Enum: BlockDeviceIoStatus
 -- Object: BlockDeviceMapEntry
 -- Enum: DirtyBitmapStatus
 -- Object: BlockDirtyInfo
 -- Object: BlockInfo
 -- Object: BlockMeasureInfo
 -- Command: query-block
 -- Object: BlockDeviceTimedStats
 -- Object: BlockDeviceStats
 -- Object: BlockStats
 -- Command: query-blockstats
 -- Enum: BlockdevOnError
 -- Enum: MirrorSyncMode
 -- Enum: BlockJobType
 -- Object: BlockJobInfo
 -- Command: query-block-jobs
 -- Command: block_passwd
 -- Command: block_resize
 -- Enum: NewImageMode
 -- Object: BlockdevSnapshotSync
 -- Object: BlockdevSnapshot
 -- Object: DriveBackup
 -- Object: BlockdevBackup
 -- Command: blockdev-snapshot-sync
 -- Command: blockdev-snapshot
 -- Command: change-backing-file
 -- Command: block-commit
 -- Command: drive-backup
 -- Command: blockdev-backup
 -- Command: query-named-block-nodes
 -- Command: drive-mirror
 -- Object: DriveMirror
 -- Object: BlockDirtyBitmap
 -- Object: BlockDirtyBitmapAdd
 -- Command: block-dirty-bitmap-add
 -- Command: block-dirty-bitmap-remove
 -- Command: block-dirty-bitmap-clear
 -- Object: BlockDirtyBitmapSha256
 -- Command: x-debug-block-dirty-bitmap-sha256
 -- Command: blockdev-mirror
 -- Command: block_set_io_throttle
 -- Object: BlockIOThrottle
 -- Command: block-stream
 -- Command: block-job-set-speed
 -- Command: block-job-cancel
 -- Command: block-job-pause
 -- Command: block-job-resume
 -- Command: block-job-complete
 -- Enum: BlockdevDiscardOptions
 -- Enum: BlockdevDetectZeroesOptions
 -- Enum: BlockdevAioOptions
 -- Object: BlockdevCacheOptions
 -- Enum: BlockdevDriver
 -- Object: BlockdevOptionsFile
 -- Object: BlockdevOptionsNull
 -- Object: BlockdevOptionsVVFAT
 -- Object: BlockdevOptionsGenericFormat
 -- Object: BlockdevOptionsLUKS
 -- Object: BlockdevOptionsGenericCOWFormat
 -- Enum: Qcow2OverlapCheckMode
 -- Object: Qcow2OverlapCheckFlags
 -- Alternate: Qcow2OverlapChecks
 -- Enum: BlockdevQcowEncryptionFormat
 -- Object: BlockdevQcowEncryption
 -- Object: BlockdevOptionsQcow
 -- Enum: BlockdevQcow2EncryptionFormat
 -- Object: BlockdevQcow2Encryption
 -- Object: BlockdevOptionsQcow2
 -- Object: BlockdevOptionsSsh
 -- Enum: BlkdebugEvent
 -- Object: BlkdebugInjectErrorOptions
 -- Object: BlkdebugSetStateOptions
 -- Object: BlockdevOptionsBlkdebug
 -- Object: BlockdevOptionsBlkverify
 -- Enum: QuorumReadPattern
 -- Object: BlockdevOptionsQuorum
 -- Object: BlockdevOptionsGluster
 -- Enum: IscsiTransport
 -- Enum: IscsiHeaderDigest
 -- Object: BlockdevOptionsIscsi
 -- Object: BlockdevOptionsRbd
 -- Object: BlockdevOptionsSheepdog
 -- Enum: ReplicationMode
 -- Object: BlockdevOptionsReplication
 -- Enum: NFSTransport
 -- Object: NFSServer
 -- Object: BlockdevOptionsNfs
 -- Object: BlockdevOptionsCurlBase
 -- Object: BlockdevOptionsCurlHttp
 -- Object: BlockdevOptionsCurlHttps
 -- Object: BlockdevOptionsCurlFtp
 -- Object: BlockdevOptionsCurlFtps
 -- Object: BlockdevOptionsNbd
 -- Object: BlockdevOptionsRaw
 -- Object: BlockdevOptionsVxHS
 -- Object: BlockdevOptions
 -- Alternate: BlockdevRef
 -- Alternate: BlockdevRefOrNull
 -- Command: blockdev-add
 -- Command: blockdev-del
 -- Command: blockdev-open-tray
 -- Command: blockdev-close-tray
 -- Command: x-blockdev-remove-medium
 -- Command: x-blockdev-insert-medium
 -- Enum: BlockdevChangeReadOnlyMode
 -- Command: blockdev-change-medium
 -- Enum: BlockErrorAction
 -- Event: BLOCK_IMAGE_CORRUPTED
 -- Event: BLOCK_IO_ERROR
 -- Event: BLOCK_JOB_COMPLETED
 -- Event: BLOCK_JOB_CANCELLED
 -- Event: BLOCK_JOB_ERROR
 -- Event: BLOCK_JOB_READY
 -- Enum: PreallocMode
 -- Event: BLOCK_WRITE_THRESHOLD
 -- Command: block-set-write-threshold
 -- Command: x-blockdev-change
1.7.2 Additional block stuff (VM related)
 -- Enum: BiosAtaTranslation
 -- Enum: FloppyDriveType
 -- Object: BlockdevSnapshotInternal
 -- Command: blockdev-snapshot-internal-sync
 -- Command: blockdev-snapshot-delete-internal-sync
 -- Command: eject
 -- Command: nbd-server-start
 -- Command: nbd-server-add
 -- Command: nbd-server-stop
 -- Event: DEVICE_TRAY_MOVED
 -- Enum: QuorumOpType
 -- Event: QUORUM_FAILURE
 -- Event: QUORUM_REPORT_BAD
1.8 Character devices
 -- Object: ChardevInfo
 -- Command: query-chardev
 -- Object: ChardevBackendInfo
 -- Command: query-chardev-backends
 -- Enum: DataFormat
 -- Command: ringbuf-write
 -- Command: ringbuf-read
 -- Object: ChardevCommon
 -- Object: ChardevFile
 -- Object: ChardevHostdev
 -- Object: ChardevSocket
 -- Object: ChardevUdp
 -- Object: ChardevMux
 -- Object: ChardevStdio
 -- Object: ChardevSpiceChannel
 -- Object: ChardevSpicePort
 -- Object: ChardevVC
 -- Object: ChardevRingbuf
 -- Object: ChardevBackend
 -- Object: ChardevReturn
 -- Command: chardev-add
 -- Command: chardev-change
 -- Command: chardev-remove
 -- Command: chardev-send-break
 -- Event: VSERPORT_CHANGE
1.9 Net devices
 -- Command: set_link
 -- Command: netdev_add
 -- Command: netdev_del
 -- Object: NetdevNoneOptions
 -- Object: NetLegacyNicOptions
 -- Object: NetdevUserOptions
 -- Object: NetdevTapOptions
 -- Object: NetdevSocketOptions
 -- Object: NetdevL2TPv3Options
 -- Object: NetdevVdeOptions
 -- Object: NetdevDumpOptions
 -- Object: NetdevBridgeOptions
 -- Object: NetdevHubPortOptions
 -- Object: NetdevNetmapOptions
 -- Object: NetdevVhostUserOptions
 -- Enum: NetClientDriver
 -- Object: Netdev
 -- Object: NetLegacy
 -- Enum: NetLegacyOptionsType
 -- Object: NetLegacyOptions
 -- Enum: NetFilterDirection
 -- Enum: RxState
 -- Object: RxFilterInfo
 -- Command: query-rx-filter
 -- Event: NIC_RX_FILTER_CHANGED
1.10 Rocker switch device
 -- Object: RockerSwitch
 -- Command: query-rocker
 -- Enum: RockerPortDuplex
 -- Enum: RockerPortAutoneg
 -- Object: RockerPort
 -- Command: query-rocker-ports
 -- Object: RockerOfDpaFlowKey
 -- Object: RockerOfDpaFlowMask
 -- Object: RockerOfDpaFlowAction
 -- Object: RockerOfDpaFlow
 -- Command: query-rocker-of-dpa-flows
 -- Object: RockerOfDpaGroup
 -- Command: query-rocker-of-dpa-groups
1.11 TPM (trusted platform module) devices
 -- Enum: TpmModel
 -- Command: query-tpm-models
 -- Enum: TpmType
 -- Command: query-tpm-types
 -- Object: TPMPassthroughOptions
 -- Object: TpmTypeOptions
 -- Object: TPMInfo
 -- Command: query-tpm
1.12 Remote desktop
 -- Command: set_password
 -- Command: expire_password
 -- Command: screendump
1.12.1 Spice
 -- Object: SpiceBasicInfo
 -- Object: SpiceServerInfo
 -- Object: SpiceChannel
 -- Enum: SpiceQueryMouseMode
 -- Object: SpiceInfo
 -- Command: query-spice
 -- Event: SPICE_CONNECTED
 -- Event: SPICE_INITIALIZED
 -- Event: SPICE_DISCONNECTED
 -- Event: SPICE_MIGRATE_COMPLETED
1.12.2 VNC
 -- Object: VncBasicInfo
 -- Object: VncServerInfo
 -- Object: VncClientInfo
 -- Object: VncInfo
 -- Enum: VncPrimaryAuth
 -- Enum: VncVencryptSubAuth
 -- Object: VncServerInfo2
 -- Object: VncInfo2
 -- Command: query-vnc
 -- Command: query-vnc-servers
 -- Command: change-vnc-password
 -- Event: VNC_CONNECTED
 -- Event: VNC_INITIALIZED
 -- Event: VNC_DISCONNECTED
1.13 Input
 -- Object: MouseInfo
 -- Command: query-mice
 -- Enum: QKeyCode
 -- Object: KeyValue
 -- Command: send-key
 -- Enum: InputButton
 -- Enum: InputAxis
 -- Object: InputKeyEvent
 -- Object: InputBtnEvent
 -- Object: InputMoveEvent
 -- Object: InputEvent
 -- Command: input-send-event
1.14 Migration
 -- Object: MigrationStats
 -- Object: XBZRLECacheStats
 -- Enum: MigrationStatus
 -- Object: MigrationInfo
 -- Command: query-migrate
 -- Enum: MigrationCapability
 -- Object: MigrationCapabilityStatus
 -- Command: migrate-set-capabilities
 -- Command: query-migrate-capabilities
 -- Enum: MigrationParameter
 -- Object: MigrateSetParameters
 -- Command: migrate-set-parameters
 -- Object: MigrationParameters
 -- Command: query-migrate-parameters
 -- Command: client_migrate_info
 -- Command: migrate-start-postcopy
 -- Event: MIGRATION
 -- Event: MIGRATION_PASS
 -- Enum: COLOMessage
 -- Enum: COLOMode
 -- Enum: FailoverStatus
 -- Command: x-colo-lost-heartbeat
 -- Command: migrate_cancel
 -- Command: migrate_set_downtime
 -- Command: migrate_set_speed
 -- Command: migrate-set-cache-size
 -- Command: query-migrate-cache-size
 -- Command: migrate
 -- Command: migrate-incoming
 -- Command: xen-save-devices-state
 -- Command: xen-set-replication
 -- Object: ReplicationStatus
 -- Command: query-xen-replication-status
 -- Command: xen-colo-do-checkpoint
1.15 Transactions
 -- Object: Abort
 -- Enum: ActionCompletionMode
 -- Object: TransactionAction
 -- Object: TransactionProperties
 -- Command: transaction
1.16 Tracing
 -- Enum: TraceEventState
 -- Object: TraceEventInfo
 -- Command: trace-event-get-state
 -- Command: trace-event-set-state
1.17 QMP introspection
 -- Command: query-qmp-schema
 -- Enum: SchemaMetaType
 -- Object: SchemaInfo
 -- Object: SchemaInfoBuiltin
 -- Enum: JSONType
 -- Object: SchemaInfoEnum
 -- Object: SchemaInfoArray
 -- Object: SchemaInfoObject
 -- Object: SchemaInfoObjectMember
 -- Object: SchemaInfoObjectVariant
 -- Object: SchemaInfoAlternate
 -- Object: SchemaInfoAlternateMember
 -- Object: SchemaInfoCommand
 -- Object: SchemaInfoEvent
1.18 Miscellanea
 -- Command: qmp_capabilities
 -- Object: VersionTriple
 -- Object: VersionInfo
 -- Command: query-version
 -- Object: CommandInfo
 -- Command: query-commands
 -- Enum: LostTickPolicy
 -- Command: add_client
 -- Object: NameInfo
 -- Command: query-name
 -- Object: KvmInfo
 -- Command: query-kvm
 -- Object: UuidInfo
 -- Command: query-uuid
 -- Object: EventInfo
 -- Command: query-events
 -- Enum: CpuInfoArch
 -- Object: CpuInfo
 -- Object: CpuInfoX86
 -- Object: CpuInfoSPARC
 -- Object: CpuInfoPPC
 -- Object: CpuInfoMIPS
 -- Object: CpuInfoTricore
 -- Object: CpuInfoOther
 -- Command: query-cpus
 -- Object: IOThreadInfo
 -- Command: query-iothreads
 -- Object: BalloonInfo
 -- Command: query-balloon
 -- Event: BALLOON_CHANGE
 -- Object: PciMemoryRange
 -- Object: PciMemoryRegion
 -- Object: PciBusInfo
 -- Object: PciBridgeInfo
 -- Object: PciDeviceClass
 -- Object: PciDeviceId
 -- Object: PciDeviceInfo
 -- Object: PciInfo
 -- Command: query-pci
 -- Command: quit
 -- Command: stop
 -- Command: system_reset
 -- Command: system_powerdown
 -- Command: cpu
 -- Command: cpu-add
 -- Command: memsave
 -- Command: pmemsave
 -- Command: cont
 -- Command: system_wakeup
 -- Command: inject-nmi
 -- Command: balloon
 -- Command: human-monitor-command
 -- Object: ObjectPropertyInfo
 -- Command: qom-list
 -- Command: qom-get
 -- Command: qom-set
 -- Command: change
 -- Object: ObjectTypeInfo
 -- Command: qom-list-types
 -- Object: DevicePropertyInfo
 -- Command: device-list-properties
 -- Command: xen-set-global-dirty-log
 -- Command: device_add
 -- Command: device_del
 -- Event: DEVICE_DELETED
 -- Enum: DumpGuestMemoryFormat
 -- Command: dump-guest-memory
 -- Enum: DumpStatus
 -- Object: DumpQueryResult
 -- Command: query-dump
 -- Event: DUMP_COMPLETED
 -- Object: DumpGuestMemoryCapability
 -- Command: query-dump-guest-memory-capability
 -- Command: dump-skeys
 -- Command: object-add
 -- Command: object-del
 -- Command: getfd
 -- Command: closefd
 -- Object: MachineInfo
 -- Command: query-machines
 -- Object: CpuDefinitionInfo
 -- Command: query-cpu-definitions
 -- Object: CpuModelInfo
 -- Enum: CpuModelExpansionType
 -- Object: CpuModelExpansionInfo
 -- Command: query-cpu-model-expansion
 -- Enum: CpuModelCompareResult
 -- Object: CpuModelCompareInfo
 -- Command: query-cpu-model-comparison
 -- Object: CpuModelBaselineInfo
 -- Command: query-cpu-model-baseline
 -- Object: AddfdInfo
 -- Command: add-fd
 -- Command: remove-fd
 -- Object: FdsetFdInfo
 -- Object: FdsetInfo
 -- Command: query-fdsets
 -- Object: TargetInfo
 -- Command: query-target
 -- Object: AcpiTableOptions
 -- Enum: CommandLineParameterType
 -- Object: CommandLineParameterInfo
 -- Object: CommandLineOptionInfo
 -- Command: query-command-line-options
 -- Enum: X86CPURegister32
 -- Object: X86CPUFeatureWordInfo
 -- Object: DummyForceArrays
 -- Enum: NumaOptionsType
 -- Object: NumaOptions
 -- Object: NumaNodeOptions
 -- Object: NumaDistOptions
 -- Object: NumaCpuOptions
 -- Enum: HostMemPolicy
 -- Object: Memdev
 -- Command: query-memdev
 -- Object: PCDIMMDeviceInfo
 -- Object: MemoryDeviceInfo
 -- Command: query-memory-devices
 -- Event: MEM_UNPLUG_ERROR
 -- Enum: ACPISlotType
 -- Object: ACPIOSTInfo
 -- Command: query-acpi-ospm-status
 -- Event: ACPI_DEVICE_OST
 -- Command: rtc-reset-reinjection
 -- Event: RTC_CHANGE
 -- Enum: ReplayMode
 -- Command: xen-load-devices-state
 -- Object: GICCapability
 -- Command: query-gic-capabilities
 -- Object: CpuInstanceProperties
 -- Object: HotpluggableCPU
 -- Command: query-hotpluggable-cpus
 -- Object: GuidInfo
 -- Command: query-vm-generation-id
